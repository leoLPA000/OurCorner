/**
 * 🔐 SERVICIO DE ROLES Y PERMISOS
 * Gestión de roles: super_admin, admin, invitado
 */

class RolesService {
    constructor() {
        this.supabase = window.supabaseClient;
        this.currentRole = null;
        this.roles = {
            SUPER_ADMIN: 'super_admin',
            ADMIN: 'admin',
            INVITADO: 'invitado'
        };
    }

    /**
     * Obtener el rol del usuario actual
     */
    async getCurrentUserRole() {
        try {
            if (!this.supabase) {
                console.error('❌ Supabase no está inicializado');
                return null;
            }

            // Primero intentar obtener el usuario de la sesión actual (más rápido)
            const { data: { session } } = await this.supabase.auth.getSession();
            
            if (!session || !session.user) {
                console.log('⚠️ No hay usuario autenticado');
                return null;
            }

            const user = session.user;

            const { data, error } = await this.supabase
                .from('user_roles')
                .select('role')
                .eq('user_id', user.id)
                .single();

            if (error) {
                console.error('❌ Error al obtener rol:', error);
                return this.roles.INVITADO; // Por defecto
            }

            this.currentRole = data?.role || this.roles.INVITADO;
            console.log('✅ Rol del usuario:', this.currentRole);
            return this.currentRole;
        } catch (err) {
            console.error('❌ Error en getCurrentUserRole:', err);
            return this.roles.INVITADO;
        }
    }

    /**
     * Verificar si el usuario tiene un rol específico
     */
    async hasRole(requiredRole) {
        const userRole = await this.getCurrentUserRole();
        if (!userRole) return false;

        // Super admin tiene acceso a todo
        if (userRole === this.roles.SUPER_ADMIN) return true;

        // Verificar rol específico
        if (userRole === requiredRole) return true;

        // Admin tiene acceso a invitado
        if (userRole === this.roles.ADMIN && requiredRole === this.roles.INVITADO) {
            return true;
        }

        return false;
    }

    /**
     * Verificar si el usuario es super admin
     */
    async isSuperAdmin() {
        const role = await this.getCurrentUserRole();
        return role === this.roles.SUPER_ADMIN;
    }

    /**
     * Verificar si el usuario es admin o super admin
     */
    async isAdmin() {
        const role = await this.getCurrentUserRole();
        return role === this.roles.ADMIN || role === this.roles.SUPER_ADMIN;
    }

    /**
     * Verificar si el usuario puede hacer CRUD
     */
    async canModify() {
        return await this.isAdmin();
    }

    /**
     * Obtener todos los usuarios con sus roles (solo super_admin)
     * Incluye usuarios antiguos sin entrada en user_roles
     */
    async getAllUsersWithRoles() {
        try {
            if (!await this.isSuperAdmin()) {
                console.error('❌ No tienes permisos para ver usuarios');
                return { success: false, error: 'No tienes permisos' };
            }

            // Usar la función RPC que combina auth.users con user_roles
            const { data, error } = await this.supabase
                .rpc('get_all_users_with_roles');

            if (error) {
                console.error('❌ Error RPC:', error);
                // Fallback: obtener solo de user_roles
                const fallback = await this.supabase
                    .from('user_roles')
                    .select('*')
                    .order('created_at', { ascending: false });
                
                if (fallback.error) throw fallback.error;
                return { success: true, data: fallback.data };
            }

            return { success: true, data };
        } catch (err) {
            console.error('❌ Error al obtener usuarios:', err);
            return { success: false, error: err.message };
        }
    }

    /**
     * Cambiar el rol de un usuario (solo super_admin)
     * Si el usuario no tiene entrada en user_roles, la crea automáticamente
     */
    async changeUserRole(userId, newRole) {
        try {
            if (!await this.isSuperAdmin()) {
                console.error('❌ No tienes permisos para cambiar roles');
                return { success: false, error: 'No tienes permisos' };
            }

            // Validar que el rol sea válido
            if (!Object.values(this.roles).includes(newRole)) {
                return { success: false, error: 'Rol no válido' };
            }

            // No permitir cambiar el propio rol de super_admin
            const { data: { session } } = await this.supabase.auth.getSession();
            const user = session?.user;
            
            if (user && user.id === userId && newRole !== this.roles.SUPER_ADMIN) {
                return { 
                    success: false, 
                    error: 'No puedes quitarte el rol de super_admin a ti mismo' 
                };
            }

            // Intentar actualizar primero
            let { data, error } = await this.supabase
                .from('user_roles')
                .update({ 
                    role: newRole, 
                    updated_at: new Date().toISOString(),
                    updated_by: user.id
                })
                .eq('user_id', userId)
                .select();

            // Si no existe, usar UPSERT para crear o actualizar
            if (error || !data || data.length === 0) {
                console.log('⚠️ Usuario sin rol asignado, creando entrada...');
                
                // Obtener el email del usuario
                const { data: userData, error: userError } = await this.supabase.auth.admin.getUserById(userId);
                const email = userData?.user?.email || 'unknown@email.com';

                const { data: upsertData, error: upsertError } = await this.supabase
                    .from('user_roles')
                    .upsert({ 
                        user_id: userId,
                        email: email,
                        role: newRole, 
                        updated_at: new Date().toISOString(),
                        updated_by: user.id
                    }, { onConflict: 'user_id' })
                    .select();

                if (upsertError) throw upsertError;
                data = upsertData;
            }

            console.log('✅ Rol actualizado exitosamente');
            return { success: true, data };
        } catch (err) {
            console.error('❌ Error al cambiar rol:', err);
            return { success: false, error: err.message };
        }
    }

    /**
     * Obtener información del rol con descripción
     */
    getRoleInfo(role) {
        const roleInfo = {
            [this.roles.SUPER_ADMIN]: {
                name: 'Super Administrador',
                color: '#ff4444',
                icon: '👑',
                description: 'Acceso total + gestión de usuarios'
            },
            [this.roles.ADMIN]: {
                name: 'Administrador',
                color: '#4caf50',
                icon: '⚙️',
                description: 'Puede crear, editar y eliminar contenido'
            },
            [this.roles.INVITADO]: {
                name: 'Invitado',
                color: '#999',
                icon: '👤',
                description: 'Solo puede visualizar contenido'
            }
        };

        return roleInfo[role] || roleInfo[this.roles.INVITADO];
    }

    /**
     * Mostrar mensaje de error cuando no hay permisos
     */
    showNoPermissionMessage() {
        alert('⚠️ No tienes permisos para realizar esta acción.\nSolo los administradores pueden modificar contenido.');
    }

    /**
     * Verificar permisos y mostrar mensaje si no tiene acceso
     */
    async checkPermissionOrAlert() {
        const canModify = await this.canModify();
        if (!canModify) {
            this.showNoPermissionMessage();
        }
        return canModify;
    }
}

// Inicializar servicio globalmente
window.rolesService = new RolesService();
console.log('✅ RolesService inicializado');

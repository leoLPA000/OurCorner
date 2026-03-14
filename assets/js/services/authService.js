/**
 * 🔐 SERVICIO DE AUTENTICACIÓN
 * Gestión completa de autenticación con Supabase Auth
 * Permite login/registro con email y contraseña
 */

class AuthService {
    constructor() {
        this.supabase = window.supabaseClient;
        this.currentUser = null;
        this.authStateListeners = [];
        
        if (!this.supabase) {
            console.error('Supabase client no está disponible');
            return;
        }
        
        // Escuchar cambios en el estado de autenticación
        this.supabase.auth.onAuthStateChange((event, session) => {
            console.log('🔄 Auth state changed:', event, session?.user?.email);
            this.currentUser = session?.user || null;
            console.log('✅ currentUser actualizado:', this.currentUser?.email || 'null');
            this.notifyAuthStateChange(event, session);
        });
        
        // Verificar sesión actual al cargar
        this.checkSession();
    }
    
    /**
     * Verificar si hay una sesión activa
     */
    async checkSession() {
        try {
            const { data: { session }, error } = await this.supabase.auth.getSession();
            
            if (error) {
                console.error('Error al verificar sesión:', error);
                return null;
            }
            
            if (session) {
                this.currentUser = session.user;
                console.log('Sesión activa detectada:', session.user.email);
                return session;
            }
            
            return null;
        } catch (error) {
            console.error('Error en checkSession:', error);
            return null;
        }
    }
    
    /**
     * Registrar nuevo usuario con username, email y contraseña
     */
    async signUpWithUsername(username, email, password) {
        try {
            // Validar username
            if (!/^[a-zA-Z0-9_]+$/.test(username) || username.length < 3 || username.length > 20) {
                return { 
                    success: false, 
                    error: 'Username inválido. Usa 3-20 caracteres: letras, números y guión bajo' 
                };
            }

            // Verificar si el username ya existe
            const { data: existingUsers, error: checkError } = await this.supabase
                .from('user_profiles')
                .select('username')
                .eq('username', username.toLowerCase())
                .maybeSingle();

            if (checkError) {
                console.error('Error verificando username:', checkError);
                return {
                    success: false,
                    error: 'No se pudo validar el nombre de usuario. Intenta nuevamente.'
                };
            }

            if (existingUsers) {
                return { 
                    success: false, 
                    error: 'Este nombre de usuario ya está en uso' 
                };
            }

            // Crear usuario en Supabase Auth con confirmación de email
            const { data, error } = await this.supabase.auth.signUp({
                email: email,
                password: password,
                options: {
                    data: {
                        username: username.toLowerCase(),
                        display_name: username,
                        created_at: new Date().toISOString()
                    },
                    emailRedirectTo: `${window.location.origin}${window.getRoute('/views/email-confirmed.html')}`
                }
            });
            
            if (error) {
                console.error('Error en registro:', error);
                
                // Mensajes de error más amigables
                if (error.message.includes('already registered')) {
                    return { success: false, error: 'Este correo ya está registrado' };
                }
                return { success: false, error: error.message };
            }
            
            if (data.user) {
                // Crear perfil de usuario en tabla separada
                const { error: profileError } = await this.supabase
                    .from('user_profiles')
                    .insert([{
                        user_id: data.user.id,
                        username: username.toLowerCase(),
                        email: email,
                        created_at: new Date().toISOString()
                    }]);

                if (profileError) {
                    console.error('Error al crear perfil:', profileError);
                    
                    // Si ya existe el perfil, no es un error crítico
                    if (!profileError.message.includes('duplicate')) {
                        return { 
                            success: false, 
                            error: 'Error al crear perfil de usuario. Intenta de nuevo.' 
                        };
                    }
                }

                console.log('Usuario registrado exitosamente:', username);
                
                // Supabase SIEMPRE requiere confirmación de email por defecto
                // El usuario debe verificar su email antes de poder iniciar sesión
                return {
                    success: true,
                    needsConfirmation: true,
                    username: username,
                    email: email,
                    message: `📧 ¡Revisa tu correo! Enviamos un mensaje a ${email} para verificar tu cuenta.`
                };
            }
            
            return { success: false, error: 'Error desconocido al registrar' };
        } catch (error) {
            console.error('Error en signUpWithUsername:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Iniciar sesión con username y contraseña
     */
    async signInWithUsername(username, password) {
        try {
            // Buscar email asociado al username
            const { data: profile, error: profileError } = await this.supabase
                .from('user_profiles')
                .select('email')
                .eq('username', username.toLowerCase())
                .maybeSingle();

            if (profileError || !profile) {
                console.error('Usuario no encontrado:', username);
                return { 
                    success: false, 
                    error: 'Usuario o contraseña incorrectos' 
                };
            }

            // Ahora hacer login con el email encontrado
            const { data, error } = await this.supabase.auth.signInWithPassword({
                email: profile.email,
                password: password
            });
            
            if (error) {
                console.error('Error en login:', error);
                
                // Detectar si el usuario no ha verificado su email
                if (error.message.includes('Email not confirmed')) {
                    return { 
                        success: false, 
                        error: '📧 Debes verificar tu email antes de iniciar sesión. Revisa tu bandeja de entrada.',
                        needsConfirmation: true
                    };
                }
                
                return { success: false, error: 'Usuario o contraseña incorrectos' };
            }
            
            if (data.user) {
                // Verificar que el email esté confirmado
                if (!data.user.email_confirmed_at) {
                    // Cerrar la sesión si no está confirmado
                    await this.supabase.auth.signOut();
                    return {
                        success: false,
                        error: '📧 Debes verificar tu email antes de iniciar sesión. Revisa tu correo.',
                        needsConfirmation: true
                    };
                }
                
                this.currentUser = data.user;
                console.log('Login exitoso:', username);
                return {
                    success: true,
                    user: data.user,
                    session: data.session,
                    username: username
                };
            }
            
            return { success: false, error: 'Error desconocido al iniciar sesión' };
        } catch (error) {
            console.error('Error en signInWithUsername:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Registrar nuevo usuario con email y contraseña (método original)
     */
    async signUp(email, password, metadata = {}) {
        try {
            const { data, error } = await this.supabase.auth.signUp({
                email: email,
                password: password,
                options: {
                    data: metadata,
                    emailRedirectTo: window.location.origin
                }
            });
            
            if (error) {
                console.error('Error en registro:', error);
                return { success: false, error: error.message };
            }
            
            if (data.user) {
                console.log('Usuario registrado exitosamente:', data.user.email);
                
                // Verificar si necesita confirmar email
                if (data.user.identities && data.user.identities.length === 0) {
                    return {
                        success: true,
                        needsConfirmation: true,
                        message: 'Por favor verifica tu email para completar el registro'
                    };
                }
                
                return {
                    success: true,
                    user: data.user,
                    message: 'Cuenta creada exitosamente'
                };
            }
            
            return { success: false, error: 'Error desconocido al registrar' };
        } catch (error) {
            console.error('Error en signUp:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Iniciar sesión con email y contraseña (método original)
     */
    async signIn(email, password) {
        try {
            const { data, error } = await this.supabase.auth.signInWithPassword({
                email: email,
                password: password
            });
            
            if (error) {
                console.error('Error en login:', error);
                return { success: false, error: error.message };
            }
            
            if (data.user) {
                this.currentUser = data.user;
                console.log('Login exitoso:', data.user.email);
                return {
                    success: true,
                    user: data.user,
                    session: data.session
                };
            }
            
            return { success: false, error: 'Error desconocido al iniciar sesión' };
        } catch (error) {
            console.error('Error en signIn:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Cerrar sesión
     */
    async signOut() {
        try {
            const { error } = await this.supabase.auth.signOut();
            
            if (error) {
                console.error('Error al cerrar sesión:', error);
                return { success: false, error: error.message };
            }
            
            this.currentUser = null;
            console.log('Sesión cerrada exitosamente');
            return { success: true };
        } catch (error) {
            console.error('Error en signOut:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Recuperar contraseña usando username
     */
    async resetPasswordByUsername(username) {
        try {
            // Buscar email asociado al username
            const { data: profile, error: profileError } = await this.supabase
                .from('user_profiles')
                .select('email')
                .eq('username', username.toLowerCase())
                .maybeSingle();

            if (profileError || !profile) {
                return { 
                    success: false, 
                    error: 'Usuario no encontrado' 
                };
            }

            // Enviar email de recuperación
            const { data, error } = await this.supabase.auth.resetPasswordForEmail(profile.email, {
                redirectTo: `${window.location.origin}/views/reset-password.html`
            });
            
            if (error) {
                return { success: false, error: error.message };
            }
            
            return {
                success: true,
                message: `Se ha enviado un enlace de recuperación al email asociado a ${username}`
            };
        } catch (error) {
            console.error('Error en resetPasswordByUsername:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Recuperar contraseña (método original con email)
     */
    async resetPassword(email) {
        try {
            const { data, error } = await this.supabase.auth.resetPasswordForEmail(email, {
                redirectTo: `${window.location.origin}/views/reset-password.html`
            });
            
            if (error) {
                return { success: false, error: error.message };
            }
            
            return {
                success: true,
                message: 'Se ha enviado un enlace de recuperación a tu email'
            };
        } catch (error) {
            console.error('Error en resetPassword:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Actualizar contraseña
     */
    async updatePassword(newPassword) {
        try {
            const { data, error } = await this.supabase.auth.updateUser({
                password: newPassword
            });
            
            if (error) {
                return { success: false, error: error.message };
            }
            
            return {
                success: true,
                message: 'Contraseña actualizada exitosamente'
            };
        } catch (error) {
            console.error('Error en updatePassword:', error);
            return { success: false, error: error.message };
        }
    }
    
    /**
     * Obtener username del usuario actual
     */
    getUserUsername() {
        if (!this.currentUser) return null;
        return this.currentUser.user_metadata?.username || null;
    }
    
    /**
     * Obtener usuario actual
     */
    getCurrentUser() {
        return this.currentUser;
    }
    
    /**
     * Verificar si el usuario está autenticado
     */
    isAuthenticated() {
        // Si currentUser es null, intentar obtener la sesión de Supabase
        if (!this.currentUser) {
            // Verificar si hay sesión en Supabase de forma síncrona
            const session = this.supabase?.auth?.getSession();
            if (session) {
                console.log('⚠️ currentUser era null, recuperando de sesión...');
            }
        }
        
        const isAuth = this.currentUser !== null;
        console.log('🔐 isAuthenticated:', isAuth, 'currentUser:', this.currentUser?.email || 'null');
        return isAuth;
    }
    
    /**
     * Obtener sesión actual
     */
    async getSession() {
        try {
            const { data: { session }, error } = await this.supabase.auth.getSession();
            return session;
        } catch (error) {
            console.error('Error al obtener sesión:', error);
            return null;
        }
    }
    
    /**
     * Registrar listener para cambios en el estado de autenticación
     */
    onAuthStateChange(callback) {
        this.authStateListeners.push(callback);
        
        // Llamar inmediatamente con el estado actual
        if (this.currentUser) {
            callback('SIGNED_IN', { user: this.currentUser });
        } else {
            callback('SIGNED_OUT', null);
        }
        
        // Retornar función para desuscribirse
        return () => {
            const index = this.authStateListeners.indexOf(callback);
            if (index > -1) {
                this.authStateListeners.splice(index, 1);
            }
        };
    }
    
    /**
     * Notificar a todos los listeners sobre cambios en autenticación
     */
    notifyAuthStateChange(event, session) {
        this.authStateListeners.forEach(callback => {
            callback(event, session);
        });
    }
    
    /**
     * Obtener token de acceso actual
     */
    async getAccessToken() {
        try {
            const session = await this.getSession();
            return session?.access_token || null;
        } catch (error) {
            console.error('Error al obtener access token:', error);
            return null;
        }
    }
    
    /**
     * Middleware para proteger funciones que requieren autenticación
     */
    requireAuth(callback, errorCallback) {
        if (this.isAuthenticated()) {
            return callback(this.currentUser);
        } else {
            if (errorCallback) {
                errorCallback();
            } else {
                alert('Debes iniciar sesión para realizar esta acción');
                window.location.href = window.getRoute('/views/login.html');
            }
            return null;
        }
    }
}

// Crear instancia global del servicio de autenticación
window.authService = new AuthService();

// Exportar para módulos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = AuthService;
}

console.log('AuthService inicializado');

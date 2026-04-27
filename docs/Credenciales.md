para hacer backup de tu base de datos usando pg_dump, necesitas las siguientes credenciales:

 Usar la Connection String (Más fácil)
En lugar de ingresar contraseña, puedes usar la connection string completa:

En Supabase > Settings > Database > Connection String
Copia la URL que veas (formato: postgresql://postgres:PASSWORD@...)
Reemplaza PASSWORD con tu contraseña
O simplemente usa esta versión que incluye usuario+host+db:

pg_dump -h db.lrjbpnzkvueralkqrsfd.supabase.co -U postgres -d postgres -F c -b -v -f "C:\laragon\www\OurCorner\backup_$(Get-Date -Format 'yyyy-MM-dd').sql"

zcRFSbuz2wgVn5Wu

conexión string completa (más fácil, sin pedir contraseña):

pg_dump "postgresql://postgres:zcRFSbuz2wgVn5Wu@db.lrjbpnzkvueralkqrsfd.supabase.co:5432/postgres" -F c -b -v -f "C:\laragon\www\OurCorner\backup_$(Get-Date -Format 'yyyy-MM-dd').sql"

Si quieres un backup que SÍ puedas abrir en un editor de texto, ejecuta este comando (formato SQL plano):

pg_dump "postgresql://postgres:zcRFSbuz2wgVn5Wu@db.lrjbpnzkvueralkqrsfd.supabase.co:5432/postgres" -F p -b -v -f "C:\laragon\www\OurCorner\backup_plaintext_$(Get-Date -Format 'yyyy-MM-dd').sql"
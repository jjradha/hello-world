use [master];
go
exec xp_instance_regwrite
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'BackupDirectory',
    REG_SZ,
    N'D:\MSSQL\Backup';
go
exec xp_instance_regwrite
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'DefaultData',
    REG_SZ,
    N'D:\MSSQL\Data';
go
exec xp_instance_regwrite
    N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer',
    N'DefaultLog',
    REG_SZ,
    N'D:\MSSQL\Logs';
go

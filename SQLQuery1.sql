USE master;
GO

CREATE TRIGGER trg_LogonAudit
ON ALL SERVER
FOR LOGON
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO AuditDB.dbo.LogonAudit (LoginName, HostName, ProgramName)
    SELECT ORIGINAL_LOGIN(),
           HOST_NAME(),
           PROGRAM_NAME();
END;
GO

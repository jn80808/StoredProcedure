IF OBJECT_ID('dbo.Prc_EmergencyContacts') IS NOT NULL
    DROP PROCEDURE dbo.Prc_EmergencyContacts
GO

CREATE PROCEDURE dbo.Prc_EmergencyContacts
(
    @ContactId      UNIQUEIDENTIFIER = NULL,
    @PatientId      UNIQUEIDENTIFIER = NULL,
    @ContactType    VARCHAR(30) = NULL,
    @Name           VARCHAR(100) = NULL,
    @Relationship   VARCHAR(50) = NULL,
    @PhoneHome      VARCHAR(20) = NULL,
    @PhoneCell      VARCHAR(20) = NULL,
    @Operation      VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_InsuranceData        
*  Input Parameters......: none              
*  Output Parameters.....: none              
*  Description...........: This stored procedure is process the personal data That will be use for API GET, POST, PUT, DELETE this is for my 
*							Peronal Project to use in Mendix App
*  Called By Procedure(s): none            
*  This Procedure Calls..: none              
*                     
*------------------------------------------------------------------------------------------------------------------------------------------             
*	Serial No:		Date:			Release No:			Modified By:       Description:              
*------------------------------------------------------------------------------------------------------------------------------------------             
*	1				07/03/2025		R1					Joy Ng				Initial Creation 
*	2    
*------------------------------------------------------------------------------------------------------------------------------------------                 
*******************************************************************************************************************************************/   
   

AS
BEGIN
    PRINT 'Execution of dbo.Prc_EmergencyContacts starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            ContactId,
            PatientId,
            ContactType,
            Name,
            Relationship,
            PhoneHome,
            PhoneCell
        FROM EmergencyContacts
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            ContactId,
            PatientId,
            ContactType,
            Name,
            Relationship,
            PhoneHome,
            PhoneCell
        FROM EmergencyContacts
        WHERE ContactId = @ContactId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO EmergencyContacts (
            ContactId,
            PatientId,
            ContactType,
            Name,
            Relationship,
            PhoneHome,
            PhoneCell
        )
        VALUES (
            ISNULL(@ContactId, NEWID()),
            @PatientId,
            @ContactType,
            @Name,
            @Relationship,
            @PhoneHome,
            @PhoneCell
        )

        SELECT TOP 1 *
        FROM EmergencyContacts
        ORDER BY ContactId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE EmergencyContacts
        SET
            PatientId = @PatientId,
            ContactType = @ContactType,
            Name = @Name,
            Relationship = @Relationship,
            PhoneHome = @PhoneHome,
            PhoneCell = @PhoneCell
        WHERE ContactId = @ContactId

        SELECT * FROM EmergencyContacts
        WHERE ContactId = @ContactId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM EmergencyContacts
        WHERE ContactId = @ContactId

        SELECT 'Delete successful' AS Message
    END

    /*------------------------------
        ---- INVALID OPERATION ----
    --------------------------------*/
    ELSE
    BEGIN
        SELECT 'Invalid Operation' AS Message
    END
END
GO

IF OBJECT_ID('dbo.Prc_ResponsibleParties') IS NOT NULL
    DROP PROCEDURE dbo.Prc_ResponsibleParties
GO

CREATE PROCEDURE dbo.Prc_ResponsibleParties
(
    @ResponsibleId           UNIQUEIDENTIFIER = NULL,
    @PatientId               UNIQUEIDENTIFIER = NULL,
    @Name                    VARCHAR(100) = NULL,
    @DOB                     DATE = NULL,
    @RelationshipToInsured   VARCHAR(50) = NULL,
    @PreferredPhone          VARCHAR(20) = NULL,
    @Operation               VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_ResponsibleParties        
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
*	1				07/01/2025		R1					Joy Ng				Initial Creation 
*	2    
*------------------------------------------------------------------------------------------------------------------------------------------                 
*******************************************************************************************************************************************/   
   
AS
BEGIN
    PRINT 'Execution of dbo.Prc_ResponsibleParties starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            ResponsibleId,
            PatientId,
            Name,
            DOB,
            RelationshipToInsured,
            PreferredPhone
        FROM ResponsibleParties
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            ResponsibleId,
            PatientId,
            Name,
            DOB,
            RelationshipToInsured,
            PreferredPhone
        FROM ResponsibleParties
        WHERE ResponsibleId = @ResponsibleId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO ResponsibleParties (
            ResponsibleId,
            PatientId,
            Name,
            DOB,
            RelationshipToInsured,
            PreferredPhone
        )
        VALUES (
            ISNULL(@ResponsibleId, NEWID()),
            @PatientId,
            @Name,
            @DOB,
            @RelationshipToInsured,
            @PreferredPhone
        )

        SELECT TOP 1 *
        FROM ResponsibleParties
        ORDER BY ResponsibleId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE ResponsibleParties
        SET
            PatientId = @PatientId,
            Name = @Name,
            DOB = @DOB,
            RelationshipToInsured = @RelationshipToInsured,
            PreferredPhone = @PreferredPhone
        WHERE ResponsibleId = @ResponsibleId

        SELECT * FROM ResponsibleParties
        WHERE ResponsibleId = @ResponsibleId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM ResponsibleParties
        WHERE ResponsibleId = @ResponsibleId

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

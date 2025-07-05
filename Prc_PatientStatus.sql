IF OBJECT_ID('dbo.Prc_PatientStatus') IS NOT NULL
    DROP PROCEDURE dbo.Prc_PatientStatus
GO

CREATE PROCEDURE dbo.Prc_PatientStatus
(
    @StatusId   UNIQUEIDENTIFIER = NULL,
    @PatientId  UNIQUEIDENTIFIER = NULL,
    @Status     VARCHAR(50) = NULL,
    @UpdatedOn  DATETIME = NULL,
    @UpdatedBy  VARCHAR(100) = NULL,
    @Operation  VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_PatientStatus        
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
    PRINT 'Execution of dbo.Prc_PatientStatus starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            StatusId,
            PatientId,
            Status,
            UpdatedOn,
            UpdatedBy
        FROM PatientStatus
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            StatusId,
            PatientId,
            Status,
            UpdatedOn,
            UpdatedBy
        FROM PatientStatus
        WHERE StatusId = @StatusId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO PatientStatus (
            StatusId,
            PatientId,
            Status,
            UpdatedOn,
            UpdatedBy
        )
        VALUES (
            ISNULL(@StatusId, NEWID()),
            @PatientId,
            @Status,
            ISNULL(@UpdatedOn, GETDATE()),
            @UpdatedBy
        )

        SELECT TOP 1 *
        FROM PatientStatus
        ORDER BY UpdatedOn DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE PatientStatus
        SET
            PatientId = @PatientId,
            Status    = @Status,
            UpdatedOn = ISNULL(@UpdatedOn, GETDATE()),
            UpdatedBy = @UpdatedBy
        WHERE StatusId = @StatusId

        SELECT * FROM PatientStatus
        WHERE StatusId = @StatusId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM PatientStatus
        WHERE StatusId = @StatusId

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

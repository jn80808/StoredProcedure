IF OBJECT_ID('dbo.Prc_LaboratoryResults') IS NOT NULL
    DROP PROCEDURE dbo.Prc_LaboratoryResults
GO

CREATE PROCEDURE dbo.Prc_LaboratoryResults
(
    @LabId         UNIQUEIDENTIFIER = NULL,
    @PatientId     UNIQUEIDENTIFIER = NULL,
    @TestType      VARCHAR(100) = NULL,
    @ResultSummary TEXT = NULL,
    @FullReport    TEXT = NULL,
    @ResultDate    DATE = NULL,
    @UploadedBy    VARCHAR(100) = NULL,
    @Operation     VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_LaboratoryResults        
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
    PRINT 'Execution of dbo.Prc_LaboratoryResults starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            LabId,
            PatientId,
            TestType,
            ResultSummary,
            FullReport,
            ResultDate,
            UploadedBy
        FROM LaboratoryResults
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            LabId,
            PatientId,
            TestType,
            ResultSummary,
            FullReport,
            ResultDate,
            UploadedBy
        FROM LaboratoryResults
        WHERE LabId = @LabId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO LaboratoryResults (
            LabId,
            PatientId,
            TestType,
            ResultSummary,
            FullReport,
            ResultDate,
            UploadedBy
        )
        VALUES (
            ISNULL(@LabId, NEWID()),
            @PatientId,
            @TestType,
            @ResultSummary,
            @FullReport,
            @ResultDate,
            @UploadedBy
        )

        SELECT TOP 1 *
        FROM LaboratoryResults
        ORDER BY LabId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE LaboratoryResults
        SET
            PatientId     = @PatientId,
            TestType      = @TestType,
            ResultSummary = @ResultSummary,
            FullReport    = @FullReport,
            ResultDate    = @ResultDate,
            UploadedBy    = @UploadedBy
        WHERE LabId = @LabId

        SELECT * FROM LaboratoryResults
        WHERE LabId = @LabId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM LaboratoryResults
        WHERE LabId = @LabId

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

IF OBJECT_ID('dbo.Prc_InsuranceData') IS NOT NULL
    DROP PROCEDURE dbo.Prc_InsuranceData
GO

CREATE PROCEDURE dbo.Prc_InsuranceData
(
    @InsuranceId     UNIQUEIDENTIFIER = NULL,
    @PatientId       UNIQUEIDENTIFIER = NULL,
    @InsuranceType   VARCHAR(20) = NULL,
    @PolicyNumber    VARCHAR(50) = NULL,
    @SubscriberName  VARCHAR(100) = NULL,
    @SubscriberDOB   DATE = NULL,
    @Operation       VARCHAR(20) = NULL
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
    PRINT 'Execution of dbo.Prc_InsuranceData starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            InsuranceId,
            PatientId,
            InsuranceType,
            PolicyNumber,
            SubscriberName,
            SubscriberDOB
        FROM Insurance
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            InsuranceId,
            PatientId,
            InsuranceType,
            PolicyNumber,
            SubscriberName,
            SubscriberDOB
        FROM Insurance
        WHERE InsuranceId = @InsuranceId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO Insurance (
            InsuranceId,
            PatientId,
            InsuranceType,
            PolicyNumber,
            SubscriberName,
            SubscriberDOB
        )
        VALUES (
            ISNULL(@InsuranceId, NEWID()),
            @PatientId,
            @InsuranceType,
            @PolicyNumber,
            @SubscriberName,
            @SubscriberDOB
        )

        SELECT TOP 1 *
        FROM Insurance
        ORDER BY InsuranceId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE Insurance
        SET
            PatientId = @PatientId,
            InsuranceType = @InsuranceType,
            PolicyNumber = @PolicyNumber,
            SubscriberName = @SubscriberName,
            SubscriberDOB = @SubscriberDOB
        WHERE InsuranceId = @InsuranceId

        SELECT * FROM Insurance
        WHERE InsuranceId = @InsuranceId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM Insurance
        WHERE InsuranceId = @InsuranceId

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

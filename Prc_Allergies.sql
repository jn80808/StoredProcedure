IF OBJECT_ID('dbo.Prc_Allergies') IS NOT NULL
    DROP PROCEDURE dbo.Prc_Allergies
GO

CREATE PROCEDURE dbo.Prc_Allergies
(
    @AllergyId          UNIQUEIDENTIFIER = NULL,
    @PatientId          UNIQUEIDENTIFIER = NULL,
    @AllergyType        VARCHAR(100) = NULL,
    @OtherAllergyNotes  TEXT = NULL,
    @Operation          VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_Allergies        
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
    PRINT 'Execution of dbo.Prc_Allergies starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            AllergyId,
            PatientId,
            AllergyType,
            OtherAllergyNotes
        FROM Allergies
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            AllergyId,
            PatientId,
            AllergyType,
            OtherAllergyNotes
        FROM Allergies
        WHERE AllergyId = @AllergyId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO Allergies (
            AllergyId,
            PatientId,
            AllergyType,
            OtherAllergyNotes
        )
        VALUES (
            ISNULL(@AllergyId, NEWID()),
            @PatientId,
            @AllergyType,
            @OtherAllergyNotes
        )

        SELECT TOP 1 *
        FROM Allergies
        ORDER BY AllergyId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE Allergies
        SET
            PatientId         = @PatientId,
            AllergyType       = @AllergyType,
            OtherAllergyNotes = @OtherAllergyNotes
        WHERE AllergyId = @AllergyId

        SELECT * FROM Allergies
        WHERE AllergyId = @AllergyId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM Allergies
        WHERE AllergyId = @AllergyId

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

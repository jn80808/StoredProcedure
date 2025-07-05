IF OBJECT_ID('dbo.Prc_Vitals') IS NOT NULL
    DROP PROCEDURE dbo.Prc_Vitals
GO

CREATE PROCEDURE dbo.Prc_Vitals
(
    @VitalsId         UNIQUEIDENTIFIER = NULL,
    @PatientId        UNIQUEIDENTIFIER = NULL,
    @HeightInches     FLOAT = NULL,
    @WeightLbs        FLOAT = NULL,
    @ShoeSize         VARCHAR(10) = NULL,
    @GenderShoe       VARCHAR(10) = NULL,
    @HemoglobinA1C    FLOAT = NULL,
    @A1CDate          DATE = NULL,
    @Operation        VARCHAR(20) = NULL
)
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_Vitals        
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
    PRINT 'Execution of dbo.Prc_Vitals starts at ' + CONVERT(VARCHAR(20), GETDATE(), 20)
    SET NOCOUNT ON;

    /*------------------------------
        ---- OPERATION GET ALL ----
    --------------------------------*/
    IF @Operation = 'GETALL'
    BEGIN
        SELECT 
            VitalsId,
            PatientId,
            HeightInches,
            WeightLbs,
            ShoeSize,
            GenderShoe,
            HemoglobinA1C,
            A1CDate
        FROM Vitals
    END

    /*------------------------------
        ---- OPERATION GETBYID ----
    --------------------------------*/
    ELSE IF @Operation = 'GETBYID'
    BEGIN
        SELECT 
            VitalsId,
            PatientId,
            HeightInches,
            WeightLbs,
            ShoeSize,
            GenderShoe,
            HemoglobinA1C,
            A1CDate
        FROM Vitals
        WHERE VitalsId = @VitalsId
    END

    /*------------------------------
        ---- OPERATION INSERT ----
    --------------------------------*/
    ELSE IF @Operation = 'INSERT'
    BEGIN
        INSERT INTO Vitals (
            VitalsId,
            PatientId,
            HeightInches,
            WeightLbs,
            ShoeSize,
            GenderShoe,
            HemoglobinA1C,
            A1CDate
        )
        VALUES (
            ISNULL(@VitalsId, NEWID()),
            @PatientId,
            @HeightInches,
            @WeightLbs,
            @ShoeSize,
            @GenderShoe,
            @HemoglobinA1C,
            @A1CDate
        )

        SELECT TOP 1 *
        FROM Vitals
        ORDER BY VitalsId DESC
    END

    /*------------------------------
        ---- OPERATION UPDATE ----
    --------------------------------*/
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE Vitals
        SET
            PatientId       = @PatientId,
            HeightInches    = @HeightInches,
            WeightLbs       = @WeightLbs,
            ShoeSize        = @ShoeSize,
            GenderShoe      = @GenderShoe,
            HemoglobinA1C   = @HemoglobinA1C,
            A1CDate         = @A1CDate
        WHERE VitalsId = @VitalsId

        SELECT * FROM Vitals
        WHERE VitalsId = @VitalsId
    END

    /*------------------------------
        ---- OPERATION DELETE ----
    --------------------------------*/
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM Vitals
        WHERE VitalsId = @VitalsId

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

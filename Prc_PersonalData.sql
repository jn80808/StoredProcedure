IF OBJECT_ID('dbo.Prc_PersonalData') IS NOT NULL
	DROP PROCEDURE dbo.Prc_PersonalData
GO

CREATE PROCEDURE Prc_PersonalData
AS
        
SET NOCOUNT ON
           
/******************************************************************************************************************************************                 
*              
*  Procedure Name........: dbo.Prc_PersonalData        
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
   
      
PRINT 'Execution of dbo.Prc_PSUSchdTdy_Inbnd  starts at ' + CONVERT(VARCHAR(20),GETDATE(),20)
  




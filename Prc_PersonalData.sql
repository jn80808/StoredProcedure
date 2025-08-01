IF OBJECT_ID('dbo.Prc_PersonalData') IS NOT NULL
	DROP PROCEDURE dbo.Prc_PersonalData
GO

CREATE PROCEDURE [dbo].[Prc_PersonalData]
(
	@FirstName		VARCHAR(100) = NULL,
	@MiddleName		VARCHAR(100) = NULL,
	@LastName		VARCHAR(100) = NULL,
	@PreferredName	VARCHAR(100) = NULL,
	@BirthDate		DATE = NULL,
	@Age			INT = NULL,
	@Sex			VARCHAR(10) = NULL,
	@SocialSecurityNumber	VARCHAR(20) = NULL,
	@PreferredLanguage		VARCHAR(50) = NULL,
	@Ethnicity				VARCHAR(255) = NULL,
	@MaritalStatus			VARCHAR(20) = NULL,
	@Occupation				VARCHAR(100) = NULL,
	@Employer				VARCHAR(100) = NULL,
	@Email					VARCHAR(100) = NULL,
	@PhoneHome				VARCHAR(20) = NULL,
	@PhoneWork				VARCHAR(20) = NULL,
	@PhoneCell				VARCHAR(20) = NULL,
	@PreferredContact		VARCHAR(10) = NULL,
	@AddressStreet			VARCHAR(255)= NULL,
	@AddressCity			VARCHAR(50) = NULL,
	@AddressState			VARCHAR(50) = NULL,
	@AddressZip				VARCHAR(20) = NULL,
	@BillingStreet			VARCHAR(255)= NULL,
	@BillingCity			VARCHAR(50) = NULL,
	@BillingState			VARCHAR(50) = NULL,
	@BillingZip				VARCHAR(20) = NULL,
	@Operation				VARCHAR(20) = NULL,
	@CreatedAt				DATETIME =  NULL,
	@PatientId				UNIQUEIDENTIFIER = NULL
)

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
   
As 
BEGIN 

	PRINT 'Execution of dbo.Prc_PersonalData  starts at ' + CONVERT(VARCHAR(20),GETDATE(),20)
	SET NOCOUNT ON;

	

/*------------------------------
	---- OPERATION GET ALL ----
--------------------------------*/

	IF @Operation = 'GETALL'
		BEGIN 
			SELECT 
			  PatientId
			 ,FirstName
			 ,MiddleName
			 ,LastName
			 ,PreferredName
			 ,BirthDate
			 ,Age
			 ,Sex
			 ,SocialSecurityNumber
			 ,PreferredLanguage
			 ,Ethnicity
			 ,MaritalStatus
			 ,Occupation
			 ,Employer
			 ,Email
			 ,PhoneHome
			 ,PhoneWork
			 ,PhoneCell
			 ,PreferredContact
			 ,AddressStreet
			 ,AddressCity
			 ,AddressState
			 ,AddressZip
			 ,BillingStreet
			 ,BillingCity
			 ,BillingState
			 ,BillingZip
			 ,CreatedAt
			From Tbl_Patients 
		END 

/*------------------------------
	---- OPERATION GETBYID  ----
--------------------------------*/

	ELSE IF @Operation = 'GETBYID'
		BEGIN 
			SELECT 
			  PatientId
			 ,FirstName
			 ,MiddleName
			 ,LastName
			 ,PreferredName
			 ,BirthDate
			 ,Age
			 ,Sex
			 ,SocialSecurityNumber
			 ,PreferredLanguage
			 ,Ethnicity
			 ,MaritalStatus
			 ,Occupation
			 ,Employer
			 ,Email
			 ,PhoneHome
			 ,PhoneWork
			 ,PhoneCell
			 ,PreferredContact
			 ,AddressStreet
			 ,AddressCity
			 ,AddressState
			 ,AddressZip
			 ,BillingStreet
			 ,BillingCity
			 ,BillingState
			 ,BillingZip
			 ,CreatedAt
			From Tbl_Patients WHERE PatientId = @PatientId
		END 

/*------------------------------
	---- OPERATION INSERT  ----
--------------------------------*/


	ELSE IF @Operation = 'INSERT'
		BEGIN 
			INSERT INTO Tbl_Patients
			(
			  PatientId
			 ,FirstName
			 ,MiddleName
			 ,LastName
			 ,PreferredName
			 ,BirthDate
			 ,Age
			 ,Sex
			 ,SocialSecurityNumber
			 ,PreferredLanguage
			 ,Ethnicity
			 ,MaritalStatus
			 ,Occupation
			 ,Employer
			 ,Email
			 ,PhoneHome
			 ,PhoneWork
			 ,PhoneCell
			 ,PreferredContact
			 ,AddressStreet
			 ,AddressCity
			 ,AddressState
			 ,AddressZip
			 ,BillingStreet
			 ,BillingCity
			 ,BillingState
			 ,BillingZip
			 ,CreatedAt
			 )
			 VALUES(
			  ISNULL(@PatientId, NEWID())
			 ,@FirstName
			 ,@MiddleName
			 ,@LastName
			 ,@PreferredName
			 ,@BirthDate
			 ,@Age
			 ,@Sex
			 ,@SocialSecurityNumber
			 ,@PreferredLanguage
			 ,@Ethnicity
			 ,@MaritalStatus
			 ,@Occupation
			 ,@Employer
			 ,@Email
			 ,@PhoneHome
			 ,@PhoneWork
			 ,@PhoneCell
			 ,@PreferredContact
			 ,@AddressStreet
			 ,@AddressCity
			 ,@AddressState
			 ,@AddressZip
			 ,@BillingStreet
			 ,@BillingCity
			 ,@BillingState
			 ,@BillingZip
			 ,GETDATE()
			 );

			SELECT TOP 1 *
			FROM Tbl_Patients
			ORDER BY CreatedAt DESC;


		END 
/*------------------------------
	---- OPERATION UPDATE  ----
--------------------------------*/

	ELSE IF @Operation = 'UPDATE'
		BEGIN 
			UPDATE  Tbl_Patients
			SET 
			 PatientId				= @PatientId
			,FirstName				= @FirstName			
			,MiddleName				= @MiddleName			
			,LastName				= @LastName			
			,PreferredName			= @PreferredName		
			,BirthDate				= @BirthDate			
			,Age					= @Age					
			,Sex					= @Sex					
			,SocialSecurityNumber	= @SocialSecurityNumber
			,PreferredLanguage		= @PreferredLanguage	
			,Ethnicity				= @Ethnicity			
			,MaritalStatus			= @MaritalStatus				
			,Occupation				= @Occupation			
			,Employer				= @Employer			
			,Email					= @Email				
			,PhoneHome				= @PhoneHome			
			,PhoneWork				= @PhoneWork			
			,PhoneCell				= @PhoneCell			
			,PreferredContact		= @PreferredContact	
			,AddressStreet			= @AddressStreet		
			,AddressCity			= @AddressCity			
			,AddressState			= @AddressState		
			,AddressZip				= @AddressZip			
			,BillingStreet			= @BillingStreet		
			,BillingCity			= @BillingCity			
			,BillingState			= @BillingState		
			,BillingZip				= @BillingZip			
			,CreatedAt				= @CreatedAt
			WHERE PatientId = @PatientId

			SELECT * FROM Tbl_Patients
			WHERE PatientId = @PatientId;

			
		END 

/*------------------------------
	---- OPERATION DELETE   ----
--------------------------------*/
	ELSE IF @Operation = 'DELETE'
		BEGIN 
			DELETE FROM Tbl_Patients 
			WHERE PatientId = @PatientId

			SELECT 'Delete successful' As Message;
		END


/*------------------------------
	---- OPERATION DELETE   ----
--------------------------------*/

	ELSE 
		BEGIN 
			SELECT 'Invalid Operation' as Message 
		END 

END  
GO



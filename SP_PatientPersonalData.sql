if OBJECT_ID ('Prc_PersonalData') IS NOT NULL
	DROP PROCEDURE Prc_PersonalData
GO
CREATE PROCEDURE [dbo].[Prc_PersonalData]  
(  
 @FirstName  VARCHAR(100) = NULL,  
 @MiddleName  VARCHAR(100) = NULL,  
 @LastName  VARCHAR(100) = NULL,  
 @PreferredName VARCHAR(100) = NULL,  
 @BirthDate  DATE = NULL,  
 @Age   INT = NULL,  
 @Sex   VARCHAR(10) = NULL,  
 @SocialSecurityNumber VARCHAR(20) = NULL,  
 @PreferredLanguage  VARCHAR(50) = NULL,  
 @Ethnicity    VARCHAR(255) = NULL,  
 @MaritalStatus   VARCHAR(20) = NULL,  
 @Occupation    VARCHAR(100) = NULL,  
 @Employer    VARCHAR(100) = NULL,  
 @Email     VARCHAR(100) = NULL,  
 @PhoneHome    VARCHAR(20) = NULL,  
 @PhoneWork    VARCHAR(20) = NULL,  
 @PhoneCell    VARCHAR(20) = NULL,  
 @PreferredContact  VARCHAR(10) = NULL,  
 @AddressStreet   VARCHAR(255)= NULL,  
 @AddressCity   VARCHAR(50) = NULL,  
 @AddressState   VARCHAR(50) = NULL,  
 @AddressZip    VARCHAR(20) = NULL,  
 @BillingStreet   VARCHAR(255)= NULL,  
 @BillingCity   VARCHAR(50) = NULL,  
 @BillingState   VARCHAR(50) = NULL,  
 @BillingZip    VARCHAR(20) = NULL,  
 @Operation    VARCHAR(120) = NULL,  
 @CreatedAt    DATETIME =  NULL,  
 @PatientId    UNIQUEIDENTIFIER = NULL  ,
 @PatientIdNumber  VARCHAR(250) = NULL ,
 @ConsultationDate  VARCHAR(250) = NULL ,
 @ConsultationType VARCHAR(250) = NULL ,
 @Reason  VARCHAR(250) = NULL ,
 @DoctorName VARCHAR(250) = NULL ,
 @Notes  VARCHAR(755) = NULL ,
 @VisitLoop VARCHAR(755) = NULL ,
 @LoopCount  INT = NULL,
 @ConsultationId UNIQUEIDENTIFIER = NULL


)  
  
/******************************************************************************************************************************************                   
*                
*  Procedure Name........: dbo.Prc_PersonalData          
*  Input Parameters......: none                
*  Output Parameters.....: none                
*  Description...........: This stored procedure is process the personal data That will be use for API GET, POST, PUT, DELETE this is for my   
*       Peronal Project to use in Mendix App  
*  Called By Procedure(s): none              
*  This Procedure Calls..: none                
*                       
*------------------------------------------------------------------------------------------------------------------------------------------               
* Serial No:  Date:   Release No:   Modified By:       Description:                
*------------------------------------------------------------------------------------------------------------------------------------------               
* 1    07/01/2025  R1     Joy Ng    Initial Creation   
* 2      
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
 ---- OPERATION GENERATEID  ----  
--------------------------------*/  
  
ELSE IF @Operation = 'GENERATEID'
BEGIN
  

    SELECT @PatientIdNumber = ISNULL(
        MAX(CAST(SUBSTRING(PatientIdNumber, 7, LEN(PatientIdNumber)) AS INT)), 
        0
    ) + 1
    FROM Tbl_Patients
    WHERE PatientIdNumber LIKE 'PTN-%';

    SET @PatientIdNumber = 'PTN-' + RIGHT('00000000000' + CAST(@PatientIdNumber AS VARCHAR(11)), 11);

    SELECT @PatientIdNumber AS PatientIdNumber;
    RETURN;
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

  IF @PatientId IS NULL OR @PatientId = ''
        SET @PatientId = NEWID();

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
     @PatientId  
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
    PatientId    = @PatientId  
   ,FirstName    = @FirstName     
   ,MiddleName    = @MiddleName     
   ,LastName    = @LastName     
   ,PreferredName   = @PreferredName    
   ,BirthDate    = @BirthDate     
   ,Age     = @Age       
   ,Sex     = @Sex       
   ,SocialSecurityNumber = @SocialSecurityNumber  
   ,PreferredLanguage  = @PreferredLanguage   
   ,Ethnicity    = @Ethnicity     
   ,MaritalStatus   = @MaritalStatus      
   ,Occupation    = @Occupation     
   ,Employer    = @Employer     
   ,Email     = @Email      
   ,PhoneHome    = @PhoneHome     
   ,PhoneWork    = @PhoneWork     
   ,PhoneCell    = @PhoneCell     
   ,PreferredContact  = @PreferredContact   
   ,AddressStreet   = @AddressStreet    
   ,AddressCity   = @AddressCity     
   ,AddressState   = @AddressState    
   ,AddressZip    = @AddressZip     
   ,BillingStreet   = @BillingStreet    
   ,BillingCity   = @BillingCity     
   ,BillingState   = @BillingState    
   ,BillingZip    = @BillingZip     
   ,CreatedAt    = @CreatedAt  
   WHERE PatientId = @PatientId  
  
   SELECT * FROM Tbl_Patients  
   WHERE PatientId = @PatientId;  
  
     
  END   
  
/*------------------------------  
 ---- OPERATION DELETE   ----  
--------------------------------*/  
 ELSE IF @Operation = 'DELETE'  
  BEGIN   

    -- delete Loop
    DELETE FROM Tbl_PatientConsultations  
    WHERE PatientId = @PatientId;  

   DELETE FROM Tbl_Patients   
   WHERE PatientId = @PatientId  
  
   SELECT 'Delete successful' As Message;  
  END  


/*------------------------------------
 ---- OPERATION GET ALL FOR loop ----  
------------------------------------*/  
  
 IF @Operation = 'GETALLLOOP'  
  BEGIN   
   SELECT   *
   From Tbl_PatientConsultations; 
  END   
  

/*-------------------------------------    
 ---- OPERATION GENERATELOOPID  ----  
---------------------------------------  */  

ELSE IF @Operation = 'GENERATELOOPID'
BEGIN
   

    SELECT @VisitLoop = ISNULL(
        MAX(CAST(SUBSTRING(VisitLoop, 7, LEN(VisitLoop)) AS INT)), 
        0
    ) + 1
    FROM Tbl_PatientConsultations
    WHERE VisitLoop LIKE 'VSTLP-%';

    SET @VisitLoop = 'VSTLP-' + RIGHT('00000000000' + CAST(@VisitLoop AS VARCHAR(11)), 11);

    SELECT @VisitLoop AS VisitLoop;
    RETURN;
END

/*-------------------------------------    
 ---- OPERATION INSERT_CONSULTATION  ----  
---------------------------------------  */ 

ELSE IF @Operation = 'INSERT_CONSULTATION'
BEGIN

    -- Get the next loop count for this patient
    --SELECT @LoopCount = ISNULL(MAX(LoopCount), 0) + 1
    --FROM Tbl_PatientConsultations
    --WHERE PatientId = @PatientId;

    -- Generate VisitLoop ID like VSTLP-00001
    SET @VisitLoop = 'VSTLP-' + RIGHT('00000' + CAST(@LoopCount AS VARCHAR), 5);

    -- Insert into consultations table
    INSERT INTO Tbl_PatientConsultations (
        ConsultationId,
        PatientId,
        ConsultationDate,
        ConsultationType,
        Reason,
        DoctorName,
        Notes,
        CreatedAt,
        VisitLoop,
        LoopCount
    )
    VALUES (
        NEWID(),
        @PatientId,
        ISNULL(@ConsultationDate, GETDATE()),
        @ConsultationType,
        @Reason,
        @DoctorName,
        @Notes,
        GETDATE(),
        @VisitLoop,
        @LoopCount
    );

    -- Return inserted row
    SELECT TOP 1 *
    FROM Tbl_PatientConsultations
    WHERE PatientId = @PatientId
    ORDER BY CreatedAt DESC;
END


/*------------------------------  
 ---- OPERATION UPDATE LOOP  ----  
--------------------------------*/  

ELSE IF @Operation = 'UPDATE_Loop'
BEGIN  
    UPDATE Tbl_PatientConsultations
    SET
         PatientId        = @PatientId
        ,ConsultationDate = @ConsultationDate
        ,ConsultationType = @ConsultationType
        ,Reason           = @Reason
        ,DoctorName       = @DoctorName
        ,Notes            = @Notes
        ,CreatedAt        = @CreatedAt
        ,VisitLoop        = @VisitLoop
        ,LoopCount        = @LoopCount
    WHERE ConsultationId = @ConsultationId;

    SELECT * FROM Tbl_PatientConsultations
    WHERE ConsultationId = @ConsultationId;
END  


/*------------------------------  
 ---- OPERATION DELETE Loop  ----  
--------------------------------*/  
ELSE IF @Operation = 'DELETE_Loop'  
BEGIN  
    -- delete loop 
    DELETE FROM Tbl_PatientConsultations  
    WHERE PatientId = @PatientId;  


    -- Confirmation
    SELECT 'Delete successful' AS Message;  
END  

/*-----------------------------*/
/*-------- DROPDWON  -------- */
/*---------------------------*/

/*---------------------------------------------
 ---- OPERATION GET FollowUpReason ----  
----------------------------------------------*/  
  
 IF @Operation = 'FollowUpReason'  
  BEGIN   
   SELECT   * From Lkp_FollowUpReason;
  END   

/*---------------------------------------------
 ---- OPERATION GET SymptomsChange----  
----------------------------------------------*/  
  
 IF @Operation = 'SymptomsChange'  
  BEGIN   
   SELECT   SymptomsChange  From Lkp_SymptomsChange;
  END   

/*---------------------------------------------
 ---- OPERATION GET PrescribedMedications ----  
----------------------------------------------*/  
  
 IF @Operation = 'PrescribedMedications'  
  BEGIN   

   SELECT Medication From Lkp_PrescribedMedications;

  END   

/*---------------------------------------------
 ---- OPERATION GET TestsOrdered ----  
----------------------------------------------*/  
  
 IF @Operation = 'TestsOrdered'  
  BEGIN   
   SELECT TestName From Lkp_TestsOrdered;
  END   

/*---------------------------------------------
 ---- OPERATION GET TreatmentResponse ----  
----------------------------------------------*/  
  
 IF @Operation = 'TreatmentResponse'  
  BEGIN   
   SELECT TreatmentResponse From Lkp_TreatmentResponse;
  END   

/*---------------------------------------------
 ---- OPERATION GET SideEffectsReported ----  
----------------------------------------------*/  
  
 IF @Operation = 'SideEffectsReported'  
  BEGIN   
   SELECT SideEffect  From Lkp_SideEffectsReported;
  END   


/*--------------------------------------------------
 ---- OPERATION GET LifestyleChangesSuggested ----  
---------------------------------------------------*/  
  
 IF @Operation = 'LifestyleChangesSuggested'  
  BEGIN   
   SELECT LifestyleChange From Lkp_LifestyleChanges ;
  END   

/*--------------------------------------------------
 ---- OPERATION GET ReferralMade ----  
---------------------------------------------------*/  
  
 IF @Operation = 'ReferralMade'  
  BEGIN   
   SELECT Referral From Lkp_ReferralMade ;
  END   

/*--------------------------------------------------
 ---- OPERATION GET ChronicConditionStatus ----  
---------------------------------------------------*/  
  
 IF @Operation = 'ChronicConditionStatus'  
  BEGIN   
   SELECT [Status] From Lkp_ChronicConditionStatus ;
  END   

/*--------------------------------------------------
 ---- OPERATION GET RequiresDiagnosticCheck ----  
---------------------------------------------------*/  
  
 IF @Operation = 'RequiresDiagnosticCheck'  
  BEGIN   
   SELECT RequiresCheck From Lkp_RequiresDiagnosticCheck ;
  END   

/*--------------------------------------------------
 ---- OPERATION GET DiagnosticCheckDetails ----  
---------------------------------------------------*/  
  
 IF @Operation = 'DiagnosticCheckDetails'  
  BEGIN   
   SELECT ISNULL(DiagnosticCheckDetails, '') AS DiagnosticCheckDetails
	FROM Lkp_DiagnosticCheckDetails;

  END   


/*--------------------------------------------------
 ---- OPERATION GET Sex Gender ----  
---------------------------------------------------*/ 


 IF @Operation = 'SexGender'  
  BEGIN   

   SELECT SexGender FROM SexGender;

  END   

/*--------------------------------------------------
 ---- OPERATION GET MaritalStatus ----  
---------------------------------------------------*/ 


 IF @Operation = 'MaritalStatus'  
  BEGIN   

   SELECT MaritalStatus FROM MaritalStatus;

  END   

/*--------------------------------------------------
 ---- OPERATION GET Ethnicity ----  
---------------------------------------------------*/ 


 IF @Operation = 'Ethnicity'  
  BEGIN   

   SELECT Ethnicity FROM Ethnicity;

  END   


/*--------------------------------------------------
 ---- OPERATION GET PreferredContact ----  
---------------------------------------------------*/ 


 IF @Operation = 'PreferredContact'  
  BEGIN   

   SELECT PreferredContact FROM PreferredContact;

  END   

/*--------------------------------------------------
 ---- OPERATION GET PreferredPaymentMethod ----  
---------------------------------------------------*/ 


 IF @Operation = 'PreferredPaymentMethod'  
  BEGIN   

   SELECT PreferredPaymentMethod FROM PreferredPaymentMethod;

  END   


/*------------------------------  
 ---- Invalid Operation   ----  
--------------------------------*/  
  
 ELSE   
  BEGIN   
   SELECT 'Invalid Operation' as Message   
  END   
  
END    



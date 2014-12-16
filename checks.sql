	
/*add pending approval*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;

      


ELSIF (v_feature.last_record<>1) THEN /*Общая проверка*/
    
      RAISE NOT_APPROPRIATE_STATUS;
    
ELSIF    v_feature.status_id = 1/*PENDING_APPROVAL_ID*/ AND v_feature.was_published = 0 THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 4/*APPROVED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
END IF;

/*amend*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;


ELSIF (v_feature.last_record<>1) THEN /*Общая проверка*/
    
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF (v_feature.linked<>1 AND v_feature.status_id=4 /*Approved*/)  /*Проверка для Feature*/
    
      RAISE EXC_LINKED_FEATURE;
END IF;

/*discard*/
 IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;
ELSIF (v_feature.last_record<>1) THEN 

      RAISE_NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 4/*APPROVED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF (v_feature.linked<>1 AND v_feature.status_id=4 /*Approved*/)  
    RAISE EXC_LINKED_FEATURE;
END IF;

/*reject*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;


ELSIF (v_feature.last_record<>1) THEN 

    RAISE NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 4/*APPROVED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
END IF;

/*approve*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;


ELSIF (v_feature.last_record<>1) THEN 

      RAISE NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 4/*APPROVED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
END IF;

/*deactivate*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;

ELSIF (v_feature.last_record<>1) THEN 

    RAISE NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 1/*PENDING_APPROVAL_ID*/ AND v_feature.was_published = 0 THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 6/*DEACTIVATED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF (v_feature.linked<>1 AND v_feature.status_id=4 /*Approved*/) 
      RAISE EXC_LINKED_FEATURE;
END IF;

/*reactivate*/
IF SQL%NOTFOUND THEN
      RAISE NO_DATA_FOUND;


ELSIF (v_feature.last_record<>1) THEN 

      RAISE NOT_APPROPRIATE_STATUS;
ELSIF    v_feature.status_id = 1/*PENDING_APPROVAL_ID*/ AND v_feature.was_published = 0 THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 2/*DISCARDED*/ OR v_feature.status_id = 3/*REJECTED*/ THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 4/*APPROVED*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
ELSIF v_feature.status_id = 5/*PENDING DEACTIVATION*/	THEN
      RAISE NOT_APPROPRIATE_STATUS;
END IF;



EXCEPTION
    /* **********************************************
     THE PLACE FOR EXCEPTIONS
     ********************************************** */
    WHEN NO_DATA_FOUND THEN
        RAISE NO_DATA_FOUND('Data not found');
    WHEN NOT_APPROPRIATE_STATUS THEN
        RAISE NOT_APPROPRIATE_STATUS(10001,'You are not able to use this system action with current status of the entity');
    WHEN EXC_LINKED_FEATURE THEN  
         RAISE EXC_LINKED_FEATURE(10002,'You are not able to amend or refuse this feature: it is linked to a product at the moment'); 
      
    /* **********************************************
     ////////////////////////////////////////////////
     ********************************************** */
  END /*procedur*/;


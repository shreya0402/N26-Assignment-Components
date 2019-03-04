({
	getProductInfo : function(component, event, helper) {
        var action = component.get("c.getContactProductInfo");
        action.setParams({
            "caseId": component.get("v.recordId")
        });        
        action.setCallback(this, function(response) {        
          	var result = response.getReturnValue();
            var state = response.getState();
            
            if(state ==='SUCCESS'){
                component.set('v.contactProductInfoList',result);
            }else{
                var errors = response.getError();
            }
        });

        $A.enqueueAction(action);
		
	}
})
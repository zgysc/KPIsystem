package com.mobicloud.kpi;

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Controller;


public class AuthIntercept implements Interceptor {
    public void intercept(ActionInvocation ai) {

        Controller controller = ai.getController();

        String  loginUser = controller.getSessionAttr("user_name");
        if (loginUser == null) {
            if(!"/".equals(ai.getControllerKey())){

                controller.redirect("/badsession");
            }else{
                //System.out.println("check user sessio ok!");
                ai.invoke();
            }
        }else{
            ai.invoke();

        }

    }
}
package com.mobicloud.kpi;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created with IntelliJ IDEA.
 * User: lion
 * Date: 13-9-22
 * Time: 上午8:29
 * To change this template use File | Settings | File Templates.
 */
public class DevPlanValidator extends Validator {
    protected void validate(Controller controller) {
        validateRequiredString("devplan.people", "peoplemsg", "负责人不能为空");

    }

    protected void handleError(Controller controller) {
        controller.keepModel(Devplan.class);

       controller.render("/addplan.jsp");
    }
}

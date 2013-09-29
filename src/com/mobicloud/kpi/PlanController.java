package com.mobicloud.kpi;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.mobicloud.kpi.util.MobicloudManager;
import groovy.lang.Binding;
import org.apache.commons.lang.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


public class PlanController extends Controller {
    public void index(){
        String exportmode=getPara("export");

        Map ci = new HashMap();
        Date date = new Date();
        int month= date.getMonth() + 1;
        ci.put("month(plan_start)", String.valueOf(month));
        List<Map<String,Object>> plans= MobicloudManager.getInstance().searchPlan(ci, null);
        setAttr("monthlastday",MobicloudManager.getInstance().getMonthLastDay(month));
        setAttr("plans", plans);
        setAttr("month", String.valueOf(month));
        if("true".equals(exportmode)){
            exportPlan(plans,String.valueOf(month));
        }else{

            render("/showplans.jsp");
        }
    }

    public void readySearch(){
        Date date = new Date();
        int i = date.getMonth() + 1;
        setAttr("month", String.valueOf(i));
        render("/searchplan.jsp");
    }

    @Before(DevPlanValidator.class)
    public void add(){
        try
        {

            Devplan plan=getModel(Devplan.class);
            plan.save();
            redirect("/plan");

        }
        catch(Exception e)
        {
            render("/addplan.jsp");
        }
    }

    public void myplan(){
        Map ci = new HashMap();
        Date date = new Date();
        int month= date.getMonth() + 1;
        ci.put("month(plan_start)", String.valueOf(month));
        ci.put("people",(String)getSessionAttr("truename"));
        List<Map<String,Object>> plans= MobicloudManager.getInstance().searchPlan(ci, null);
        setAttr("monthlastday",MobicloudManager.getInstance().getMonthLastDay(month));
        setAttr("plans", plans);
        setAttr("month", String.valueOf(month));
        render("/showplans.jsp");

    }
    public void search(){
        String projname=getPara("proj_name");
        String people = getPara("people");
        String month = getPara("month");
        String market_func = getPara("market_func");
        String finishflag = getPara("finishflag");
        Map ci = new HashMap();
        if(!"ALL".equals(projname))
            ci.put("proj_name", projname);
        if(!"ALL".equals(people))
            ci.put("people", people);
        ci.put("month(plan_start)", month);
        if(!"ALL".equals(market_func)) ci.put("market_named_func",market_func);
        if(!"ALL".equals(finishflag)) ci.put("unfinished","1");
        String order1 = getAttrForStr("order1");
        String order2 = getAttrForStr("order2");
        String order3 = getAttrForStr("order3");
        String order4 = getAttrForStr("order4");
        HashSet set = new HashSet();
        if(StringUtils.isNotEmpty(order1))
            set.add(order1);
        if(StringUtils.isNotEmpty(order2))
            set.add(order2);
        if(StringUtils.isNotEmpty(order3))
            set.add(order3);
        if(StringUtils.isNotEmpty(order4))
            set.add(order4);
        String order = StringUtils.join(set.toArray(), ",");
        List<Map<String,Object>> plans= MobicloudManager.getInstance().searchPlan(ci, order);
        Date date = new Date();
        int i = date.getMonth() + 1;
        if(!"ALL".equals(month))    i = Integer.parseInt(month);
        setAttr("monthlastday",MobicloudManager.getInstance().getMonthLastDay(i));
        setAttr("plans", plans);
        setAttr("month", month);
        if("true".equals(getPara("export")))
            exportPlan(plans,month);
        else
            render("/showplans.jsp");
    }
    public void exportPlan(List<Map<String,Object>> plan,String month){
         //String month = (String)getAttrForStr("month");
         int curmonth = MobicloudManager.getInstance().getCurMonth(month);
         int monthlastday = MobicloudManager.getInstance().getMonthLastDay(curmonth);
         StreamRender render=new StreamRender(curmonth,monthlastday,plan);
         render(render);
    }
    public void delete(){
       Devplan.dao.deleteById(getParaToInt(0));
       redirect("/plan/");
    }
    public void update(){
       int id=getParaToInt("id");
       String planstart=getPara("plan_start");
       String planend=getPara("plan_end");
       String actstart=getPara("actual_start");
       String actend=getPara("actual_end");
       String percent=getPara("percentage");
       String des=getPara("desp");
       Devplan plan=Devplan.dao.findById(id);
       plan.set("plan_start",planstart);
       plan.set("plan_end",planend);
       plan.set("actual_start","".equals(actstart)?null:actstart);
       plan.set("actual_end","".equals(actend)?null:actend);
       plan.set("percentage","".equals(percent)?"0":percent);
       plan.set("description",des);
       plan.update();
       redirect("/plan");
    }


    private boolean compareDate(String date1,String date2){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            Date d1 = sdf.parse(date1);
            Date d2 = sdf.parse(date2);
            return d2.before(d1);
        } catch (ParseException e) {
            return false;
        }

    }

}

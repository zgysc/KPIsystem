package com.mobicloud.kpi;

import com.jfinal.core.Controller;
import com.mobicloud.kpi.util.DES;

import java.util.ArrayList;
import java.util.List;


public class CenterController extends Controller {

    public void index(){
        render("/login.jsp");
    }

    public void login(){
        String username=getPara("username");
        String password=getPara("password");
        password = DES.encrypt(password);
        Users user=Users.dao.findFirst("select * from users where user_name=? and password=?",username,password);
        if(user==null){
            redirect("/");

        }else{
            setSessionAttr("user_id",String.valueOf(user.get("user_id")));
            setSessionAttr("user_name",user.getStr("user_name"));
            //setSessionAttr("login", user.getUserName());
            setSessionAttr("truename", user.getStr("note"));
            setSessionAttr("user_info", user);
            List<Menu> menus=getUserMenus(user.getStr("email"));
            if(menus==null) menus=new ArrayList<Menu>();
            setAttr("menuList",menus);

            render("/iop.jsp");
        }
    }
    public void logout(){
        removeSessionAttr("user_info");
        removeSessionAttr("truename");
        removeSessionAttr("user_name");
        removeSessionAttr("user_id");
        removeAttr("menuList");
        redirect("/");
    }
    public void readySearchPlan(){
        redirect("/plan/readySearch");
    }
    private List<Menu> getUserMenus(String menuids){
       return Menu.dao.find("select * from menu where menu_id in("+menuids+") order by menu_order");

    }
}

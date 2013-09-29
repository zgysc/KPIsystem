package com.mobicloud.kpi;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.mobicloud.kpi.util.DES;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;


public class CenterController extends Controller {

    public void index(){
        render("/login.jsp");
    }
    public void badsession(){
        render("/tologin.jsp");
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
    public void editowninfo(){
        String password = getPara("password");
        String confirmPassword = getPara("confirmpassword");
        String username=(String)getSessionAttr("user_name");
        Users olduser=Users.dao.findFirst("select * from users where user_name=?",username);
        if(olduser!=null){
            olduser.set("password",DES.encrypt(password)).save();
            setAttr("setok","yes");

        }
        render("/editowninfo.jsp");
    }
    private String getColor(int i){
        int ret=i%8;
        switch (ret){
            case 1: return "0x333333";
            case 2: return "0x8f8fff";
            case 3: return "0xf00000";
            case 4: return "0x00ff00";
            case 5: return "0xffa500";
            case 6: return "0x191970";
            case 7: return "0x4682b4";
            default: return "0x8f8fff";
        }
    }
    private String getY(int i){
        int ret=i%8;
        switch (ret){
            case 1: return "15";
            case 2: return "20";
            case 3: return "25";
            case 4: return "30";
            case 5: return "35";
            case 6: return "40";
            case 7: return "30";
            default: return "20";
        }
    }
    public void flexshow() {
        List<Record> recordList = Db.find("select b.borrow_date ,u.note ,b.people,b.id as bid,m.* from mobile_info m, borrow_mobile b, users u where  m.id = b.mobile and   b.people= u.user_name");
        StringBuffer sb = new StringBuffer("<?xml version=\"1.0\" encoding=\"gb2312\"?>\n");
        sb.append("<Graph>\n<Node id=\"0\" name=\"设备中心\" desc=\"MObileCloud\" nodeColor=\"0x333333\" nodeSize=\"40\" nodeClass=\"earth\" nodeIcon=\"url::assets/icons/Earth.png\" x=\"10\" y=\"10\" />\n");
        int i_color = 0;

        HashSet<String> peoples = new HashSet<String>();
        HashSet<String> mobiles = new HashSet<String>();
        HashSet<String> cards = new HashSet<String>();
        for (Record record : recordList) {
            i_color++;

            String peopleid = record.getStr("people");
            if (!peoples.contains(peopleid)) {
                sb.append("<Node id=\"").append(peopleid).append("\" name=\"").append(record.getStr("note")).append("\" desc=\"\" nodeColor=\"").append(getColor(i_color)).append("\" nodeSize=\"32\" nodeClass=\"tree\" nodeIcon=\"center\" x=\"10\" y=\"").append(getY(i_color)).append("\"/>\n");
                sb.append("<Edge fromID=\"0\" toID=\"" + peopleid + "\" edgeLabel=\"\" flow=\"50\" color=\"0x556b2f\" edgeClass=\"\" edgeIcon=\"\" />\n");
                peoples.add(peopleid);
            }
            if (record.getStr("vender").startsWith("SIM")) {
                String cardid = "card" + String.valueOf(record.get("id"));
                if (!cards.contains(cardid)) {
                    sb.append("<Node id=\"").append(cardid).append("\" name=\"").append(record.getStr("phone_number")).append("\" desc=\"" + record.getStr("serial") + "\" nodeColor=\"").append(getColor(i_color)).append("\" nodeSize=\"32\" nodeClass=\"tree\" nodeIcon=\"url::assets/icons/simcard.png\" x=\"10\" y=\"").append(getY(i_color)).append("\"/>\n");
                    sb.append("<Edge fromID=\"" + peopleid + "\" toID=\"" + cardid + "\" edgeLabel=\"\" flow=\"50\" color=\"0x556b2f\" edgeClass=\"\" edgeIcon=\"\" />\n");
                    cards.add(cardid);
                }
            } else {
                String mobileid = "m" + String.valueOf(record.get("bid"));
                if (!mobiles.contains(mobileid)) {
                    sb.append("<Node id=\"").append(mobileid).append("\" name=\"").append(record.getStr("vender") + record.getStr("model")).append("\" desc=\"" + String.valueOf(record.get("borrow_date")) + "\" nodeColor=\"").append(getColor(i_color)).append("\" nodeSize=\"32\" nodeClass=\"tree\" nodeIcon=\"url::assets/icons/android.gif\" x=\"10\" y=\"").append(getY(i_color)).append("\"/>\n");
                    sb.append("<Edge fromID=\"" + peopleid + "\" toID=\"" + mobileid + "\" edgeLabel=\"\" flow=\"50\" color=\"0x556b2f\" edgeClass=\"\" edgeIcon=\"\" />\n");

                    mobiles.add(mobileid);
                }
                if (record.getStr("phone_number") != null && record.getStr("phone_number").startsWith("1")) {
                    //node
                    String cardid = "card" + String.valueOf(record.get("id"));
                    if (!cards.contains(cardid)) {
                        sb.append("<Node id=\"").append(cardid).append("\" name=\"").append(record.getStr("phone_number")).append("\" desc=\"" + record.getStr("serial") + "\" nodeColor=\"").append(getColor(i_color)).append("\" nodeSize=\"32\" nodeClass=\"tree\" nodeIcon=\"url::assets/icons/simcard.png\" x=\"10\" y=\"").append(getY(i_color)).append("\"/>\n");
                        sb.append("<Edge fromID=\"" + mobileid + "\" toID=\"" + cardid + "\" edgeLabel=\"\" flow=\"50\" color=\"0x556b2f\" edgeClass=\"\" edgeIcon=\"\" />\n");
                        cards.add(cardid);
                    }
                }
            }
        }
        sb.append("</Graph>");
        renderText(sb.toString(), "text/xml");
    }
}

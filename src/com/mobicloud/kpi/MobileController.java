package com.mobicloud.kpi;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

/**
 * MobileController
 */
public class MobileController extends Controller {
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
    public void index() {
        List<Record> recordList= Db.find("select * from borrowinfo");
        List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
        for(Record record:recordList){
            list.add(record.getColumns());
        }
        setAttr("results",list);
		render("/mobile/index.jsp");
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
    public void add() {
        List<Record> recordList= Db.find("select id,concat(id,'.',vender,model,phone_number) info from mobile_info");
        List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
        for(Record record:recordList){
            list.add(record.getColumns());
        }
        setAttr("mobiles",list);
        List<Users> users=Users.dao.find("select * from users");
        setAttr("users",users);
        render("/mobile/add.jsp");
    }

    public void save() {
        Borrow_mobile bm=getModel(Borrow_mobile.class);
        bm.set("borrow_date",new java.util.Date());
        bm.save();
        redirect("/mobile/index.jsp");
    }



    public void delete() {
        Db.deleteById("borrow_mobile",getParaToInt("id"));
        redirect("/mobile/index.jsp");
    }

}

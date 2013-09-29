package com.mobicloud.kpi.util;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import com.mobicloud.kpi.*;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.*;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


public class MobicloudManager {
    private static Log log= LogFactory.getLog(MobicloudManager.class);
    private MobicloudManager() {
    }
    private static class builder {
        static MobicloudManager _instance = new MobicloudManager();
    }
    public static MobicloudManager getInstance() {
        return builder._instance;
    }

    /*public int delPlan(String id)
    {
        return Devplan.dao.deleteById(id)?1:0;
    }

    public List getPriseHistory(String user_id, boolean isDesc)
    {
        return dao.getPriseHistory(user_id, isDesc);
    }

    public int addplan(String user_name, String proj_name, String order_type, String order_number, String marked_func, String rd_func, String curstep,
                       String people, String plan_start, String plan_end, String desp)
    {
        return dao.addPlan(user_name, proj_name, order_type, order_number, marked_func, rd_func, curstep, people, plan_start, plan_end, desp);
    }
*/
    public List<Proj> getAllProject()
    {
        return Proj.dao.find("select * from proj");
    }

    public List<MarketFunc> getAllMaretFunc(){
        return MarketFunc.dao.find("select * from market_func");
    }

    public List<OrderType> getAllOrderType(){
        return OrderType.dao.find("select * from order_type");
    }

    public List<Users> getAllUsers(){
        return Users.dao.find("select * from users where level=1");
    }

    public List<CurStep> getAllSteps(){
        return CurStep.dao.find("select * from curstep");
    }

    public List<Map<String,Object>> searchPlan(Map c)
    {
        return searchPlan(c, "");
    }
    public List<Users> getPHB(){
        return Users.dao.find("select * from users where level=1 order by dd_number desc");
    }
    public List<Map<String,Object>> searchPlan(Map c, String order)
    {
        StringBuffer sql;
        sql = (new StringBuffer()).append("select *,dayofmonth(plan_start) as startpos,datediff(plan_start,actual_start) as startdelay,datediff(plan_end,plan_start) as daycost,DAYOFMONTH(last_day(plan_start)) lastday from devplan ");
        boolean flag = true;
        if(c != null && !c.isEmpty())
        {
            for(Iterator i$ = c.entrySet().iterator(); i$.hasNext();)
            {
                java.util.Map.Entry ci = (java.util.Map.Entry)i$.next();
                if("people".equals(ci.getKey())){
                    sql.append((flag ? " where " : " and ")).append((String)ci.getKey()).append(" like '%").append((String)ci.getValue()).append("%'");
                }else if("unfinished".equals(ci.getKey())){
                    sql.append((flag ? " where " : " and ")).append(" plan_end<now() and percentage<100");
                }else
                    sql.append((flag ? " where " : " and ")).append((String)ci.getKey()).append("='").append((String)ci.getValue()).append("'");
                flag = false;
            }

        }
        if(StringUtils.isEmpty(order))
            sql.append(" order by proj_name,order_type,people,plan_start");
        else
            sql.append(" order by ").append(order);
        List<Map<String,Object>> plans = new ArrayList<Map<String,Object>>();
        log.info("search sql:"+sql.toString());
        try
        {
            List<Record> records=Db.find(sql.toString()) ;
            for(Record record:records){
                plans.add(fillPlan(record.getColumns()));
            }
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        return plans;
    }
    private Map<String,Object> fillPlan(Map<String,Object> result){
        Map<String,Object> maps=new HashMap<String,Object>();
        maps.put("id",String.valueOf(result.get("id")));
        maps.put("proj_name",String.valueOf(result.get("proj_name")));
        maps.put("order_type",MobicloudManager.getInstance().getOrderTypeName(((Integer)result.get("order_type")).intValue()));

        maps.put("order_number",(String)result.get("order_number"));
        maps.put("market_named_func",(String)result.get("market_named_func"));
        maps.put("rd_named_func",(String)result.get("RD_named_func"));
        maps.put("dep_name",(String)result.get("dep_name"));
        maps.put("curstep",String.valueOf(result.get("curstep")));
        maps.put("people",(String)result.get("people"));
        maps.put("plan_start",String.valueOf(result.get("plan_start")));
        maps.put("plan_end",String.valueOf(result.get("plan_end")));
        maps.put("plan_start_pos",((Long)result.get("startpos")).intValue());
        int daycost=((Long)result.get("daycost")).intValue();
        daycost +=1;
        maps.put("daycost",daycost);
        if(result.get("actual_start")==null){
            maps.put("actual_start","");
        }else{
            maps.put("actual_start",String.valueOf(result.get("actual_start")));
        }
        if(result.get("actual_end")==null){
            maps.put("actual_end","");
        }else{
            maps.put("actual_end",String.valueOf(result.get("actual_end")));
        }
        maps.put("startDelay",(result.get("startdelay")==null?0:((Long)result.get("startdelay")).intValue()));
        maps.put("lastday",((Long)result.get("lastday")).intValue());
        maps.put("percentage",String.valueOf(result.get("percentage")));
        maps.put("description",(String)result.get("description"));
        String color="#babaff";
        if("2".equals(String.valueOf(result.get("curstep")))){
           color="#0000ff";
        }else if("4".equals(String.valueOf(result.get("curstep")))){
           color="#ffaaff";
        }


        if((Integer)maps.get("startDelay")<0) {
            color="#ff0000";
        }
        if(compareDate(maps.get("plan_end").toString(),maps.get("actual_end").toString())){
            color="#00ff00";
        }
        if("100".equals(String.valueOf(result.get("percentage")))) color="#00ff00";
        maps.put("color",color);
        return maps;
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
    public List getPlanByMonth(String month)
    {
        Map c = new HashMap();
        c.put("month(plan_start)", month);
        return searchPlan(c, "");
    }

    private  void addCell(int start, HSSFCellStyle style, HSSFRow row, String v[])
    {
        for(int i = 0; i < v.length; i++)
        {
            HSSFCell cell = row.createCell((short)(i + start));
            cell.setCellType(1);
            cell.setCellValue(v[i]);
            if(style != null)
                cell.setCellStyle(style);
        }

    }

    public int getCurMonth(String month)
    {
        Date date = new Date();
        int i = date.getMonth() + 1;
        if(StringUtils.isEmpty(month))
            month = String.valueOf(i);
        else
            i = Integer.parseInt(month);
        return i;
    }

    public int getMonthLastDay(int i)
    {
        int monthlastday = 31;
        switch(i)
        {
            case 2: // '\002'
                monthlastday = 29;
                break;

            case 4: // '\004'
            case 6: // '\006'
            case 9: // '\t'
            case 11: // '\013'
                monthlastday = 30;
                break;
        }
        return monthlastday;
    }

    public void writeExcel(int month, int monthlastday, List<Map<String,Object>> plans, OutputStream os)
    {
        try{
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            workbook.setSheetName(0, "KPI");
            HSSFCellStyle redstyle = workbook.createCellStyle();
            HSSFCellStyle bluestyle = workbook.createCellStyle();
            HSSFCellStyle greenstyle = workbook.createCellStyle();
            HSSFCellStyle workstyle = workbook.createCellStyle();
            HSSFCellStyle pinkstyle = workbook.createCellStyle();
            redstyle.setFillForegroundColor((short)10);
            redstyle.setFillPattern((short)1);
            bluestyle.setFillForegroundColor((short)53);
            bluestyle.setFillPattern((short)1);
            greenstyle.setFillForegroundColor((short)11);
            greenstyle.setFillPattern((short)1);
            workstyle.setFillForegroundColor((short)48);
            workstyle.setFillPattern((short)1);
            pinkstyle.setFillForegroundColor((short)14);
            pinkstyle.setFillPattern((short)1);
            HSSFRow row = sheet.createRow(0);
            addCell(0, null, row, new String[] {
                    "项目", "类别", "需求名称", "分解模块", "负责人"
            });
            for(int i = 1; i <= monthlastday; i++)
                addCell(4 + i, null, row, new String[] {
                        (new StringBuilder()).append(String.valueOf(i)).append("号").toString()
                });

            int rowid = 1;
            for(Map<String,Object> dp:plans)
            {

                HSSFRow trow = sheet.createRow((short)rowid);
                addCell(0, null, trow, new String[] {
                        String.valueOf(dp.get("proj_name"))
                });
                addCell(1, null, trow, new String[] {
                        String.valueOf(dp.get("order_type"))
                });
                addCell(2, null, trow, new String[] {
                        String.valueOf(dp.get("market_named_func"))
                });
                addCell(3, null, trow, new String[] {
                        String.valueOf(dp.get("rd_named_func"))
                });
                addCell(4, null, trow, new String[] {
                        String.valueOf(dp.get("people"))
                });
                for(int j = 1; j < (Integer)dp.get("plan_start_pos"); j++)
                    addCell(4 + j, null, trow, new String[] {
                            " "
                    });

                for(int dc = 0; dc < (Integer)dp.get("daycost"); dc++)
                {
                    HSSFCellStyle curstyle;
                    if("#babaff".equals(dp.get("color")))
                        curstyle = workstyle;
                    else
                    if("#ea9900".equals(dp.get("color")))
                        curstyle = bluestyle;
                    else
                    if("#ffaaff".equals(dp.get("color")))
                        curstyle = pinkstyle;
                    else
                    if("#00ff00".equals(dp.get("color")))
                        curstyle = greenstyle;
                    else
                    if("#ff0000".equals(dp.get("color")))
                        curstyle = redstyle;
                    else
                        curstyle = null;
                    if(dc == (Integer)dp.get("daycost") / 2)
                        addCell(dc + (Integer)dp.get("plan_start_pos") + 4, curstyle, trow, new String[] {
                                (new StringBuilder()).append(dp.get("percentage")).append("%").toString()
                        });
                    else
                        addCell(dc + (Integer)dp.get("plan_start_pos") + 4, curstyle, trow, new String[] {
                                " "
                        });
                }

                for(int k = 0; k < ((Integer)dp.get("lastday") - (Integer)dp.get("plan_start_pos") - (Integer)dp.get("daycost")) + 1; k++)
                    addCell((Integer)dp.get("plan_start_pos") + 4 + (Integer)dp.get("daycost") + k, null, trow, new String[] {
                            " "
                    });

                rowid++;
            }

            workbook.write(os);  }
        catch(Exception e){
            e.printStackTrace();
        }finally {
            try
            {
                os.flush();
                os.close();
            } catch(Exception ee){}
        }


    }



    public String getRank(int num)
    {
        if(num <= 50)
            return "<img src=\"images/lv3.gif\">";
        if(num <= 100)
            return "<img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 200)
            return "<img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 500)
            return "<img src=\"images/lv2.gif\">";
        if(num <= 1000)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 1500)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 2100)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 2900)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\">";
        if(num <= 3900)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 5000)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 7000)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\"><img src=\"images/lv3.gif\">";
        if(num <= 9000)
            return "<img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\"><img src=\"images/lv2.gif\">";
        else
            return "<img src=\"images/lv1.gif\">";
    }

    public  int Collectask(String asks[])
    {
        try
        {
            return Db.update("insert into ask(operator,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", asks);
        }
        catch(Exception e)
        {
            return 0;
        }
    }
    public String getOrderTypeName(int order_type){
        if(1==order_type){
            return "正常计划";
        }else if(2==order_type){
            return "运营实施";
        }else if(3==order_type){
            return "紧急调配";
        }else{
            return String.valueOf(order_type);
        }
        /*String ordertype="";
        Binding binding=new Binding();
        binding.setProperty("order_type",order_type);
        binding.setVariable("order_type",order_type);
        GroovyScriptManager.getInstance().runScript("ordertype.groovy",binding);
        ordertype= (String)binding.getProperty("ordertype");
        return ordertype;*/

    }
    public String defaultstring(Object src){
         if(src==null) return "";
        if("null".equals(src.toString())) return "";
        return String.valueOf(src);
    }
    public List<Map<String,Object>> getPriseHistory(String user_id){

        String sql = "select p.*,u.note truename from prisehistory p,users u where p.user_id=u.user_id";
        if(user_id!=null && !"".equals(user_id)){
            sql = sql + " and p.user_id="+user_id;
        }
        sql =sql +" order by p.thedate desc";
        List<Record> list=Db.find(sql);
        List<Map<String,Object>> mapList=new ArrayList<Map<String, Object>>();
        for(Record record:list){
            mapList.add(record.getColumns());
        }
        return mapList;
    }
}

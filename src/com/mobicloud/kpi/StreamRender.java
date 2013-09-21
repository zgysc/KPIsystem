package com.mobicloud.kpi;


import com.jfinal.render.Render;
import com.mobicloud.kpi.util.MobicloudManager;

import java.util.List;
import java.util.Map;

public class StreamRender extends Render{
    private int month=1;
    private int monthlastday;
    private List<Map<String,Object>> plans;
    public StreamRender(int month, int monthlastday, List plans){
        this.month=month;
        this.monthlastday=monthlastday;
        this.plans=plans;
    }


    @Override
    public void render() {
        response.setHeader("Pragma","no-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", (new StringBuilder()).append("attachment;filename=\"Search_Month_").append(month).append("_KPI.xls\"").toString());
        try{
            java.io.OutputStream os = response.getOutputStream();
            MobicloudManager.getInstance().writeExcel(month,monthlastday,plans,os);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}

package com.mobicloud.kpi;

import com.jfinal.plugin.activerecord.Model;

/**
 * Created with IntelliJ IDEA.
 * User: lion
 * Date: 13-9-25
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 */
public class PriseInfo extends Model<PriseInfo> {
    private String truename="";
    public static final PriseInfo dao=new PriseInfo();
    public String getTruename(){
        return truename;
    }
    public void setTruename(String truename){
        this.truename=truename;
    }
}

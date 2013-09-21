package com.mobicloud.kpi;

import groovy.lang.Binding;
import groovy.util.GroovyScriptEngine;

import java.net.URL;

/**
 * Created with IntelliJ IDEA.
 * User: lion
 * Date: 13-9-21
 * Time: 上午9:58
 * To change this template use File | Settings | File Templates.
 */
public class GroovyScriptManager {
    private GroovyScriptManager()
    {
    }

    public static GroovyScriptManager getInstance()
    {
        if(_instance == null)
            _instance = new GroovyScriptManager();
        return _instance;
    }

    public void runScript(String scriptName, Binding binding)
    {
        try
        {
            engine.run(scriptName, binding);
        }
        catch(Exception e)
        {
        }
    }

    private static GroovyScriptManager _instance = null;
    private static final String SCRIPT_ROOT_DIR = "scripts/";
    private final GroovyScriptEngine engine = new GroovyScriptEngine(new URL[] {
            getClass().getClassLoader().getResource("scripts/")
    });

    public static void main(String[] args){
        String ordertype="";
        Binding binding=new Binding();
        binding.setProperty("order_type",2);
        binding.setVariable("order_type",2);
        GroovyScriptManager.getInstance().runScript("ordertype.groovy",binding);
        ordertype= (String)binding.getVariable("ordertype");
        System.out.println(ordertype);
    }
}

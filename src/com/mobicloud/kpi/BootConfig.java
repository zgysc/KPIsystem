package com.mobicloud.kpi;

import com.jfinal.config.*;
import com.jfinal.core.JFinal;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.JspRender;
import com.jfinal.render.ViewType;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * API引导式配置
 */
public class BootConfig extends JFinalConfig {
	 private static Log log= LogFactory.getLog(BootConfig.class);
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		loadPropertyFile("db.conf");				// 加载少量必要配置，随后可用getProperty(...)获取值
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP); 							// 设置视图类型为Jsp，否则默认为FreeMarker
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/", CenterController.class);
		me.add("/plan", PlanController.class);
	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
        log.info(String.format("read db info url:%s, user:%s, pwd:%s",getProperty("jdbcUrl"), getProperty("user"), getProperty("password")));
		// 配置C3p0数据库连接池插件
		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		me.add(c3p0Plugin);
		
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		me.add(arp);
		arp.addMapping("users","user_id", Users.class);	// 映射blog 表到 Blog模型
		//arp.addMapping("borrow_mobile", Borrow_mobile.class);	// 映射blog 表到 Blog模型
        arp.addMapping("menu",Menu.class);
        arp.addMapping("proj",Proj.class);
        arp.addMapping("market_func",MarketFunc.class);
        arp.addMapping("order_type",OrderType.class);
        arp.addMapping("curstep",CurStep.class);
        arp.addMapping("devplan",Devplan.class);
        arp.addMapping("prisehistory",PriseInfo.class);
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		 me.add(new AuthIntercept());
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
        JspRender.setSupportActiveRecord(false);
	}
	
	/**
	 * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此

	public static void main(String[] args) {
		JFinal.start("WebRoot", 9000, "/", 5);
	} */
}

##### 第一种方式

	VO
	
	package com.ane56.bi.domain.basic;
	
	import java.util.Date;
	
	/**
	
	- @author huliangjun
	- @date 2018-07-27 17:57:49 全流程查看VO
	  *
	   */
	  public class IdxOperStepVO {
	  private String idxSplitId;
	  private String operType;
	  private String desc;
	  private String operDepartment;
	  private String operator;
	  private Date operTime;
	  public IdxOperStepVO() {
	  	super();
	  }
	  public IdxOperStepVO(String idxSplitId, String operType, String desc, String operDepartment, String operator,
	  		Date operTime) {
	  	super();
	  	this.idxSplitId = idxSplitId;
	  	this.operType = operType;
	  	this.desc = desc;
	  	this.operDepartment = operDepartment;
	  	this.operator = operator;
	  	this.operTime = operTime;
	  }
	  public String getIdxSplitId() {
	  	return idxSplitId;
	  }
	  public void setIdxSplitId(String idxSplitId) {
	  	this.idxSplitId = idxSplitId;
	  }
	  public String getOperType() {
	  	return operType;
	  }
	  public void setOperType(String operType) {
	  	this.operType = operType;
	  }
	  public String getDesc() {
	  	return desc;
	  }
	  public void setDesc(String desc) {
	  	this.desc = desc;
	  }
	  public String getOperDepartment() {
	  	return operDepartment;
	  }
	  public void setOperDepartment(String operDepartment) {
	  	this.operDepartment = operDepartment;
	  }
	  public String getOperator() {
	  	return operator;
	  }
	  public void setOperator(String operator) {
	  	this.operator = operator;
	  }
	  public Date getOperTime() {
	  	return operTime;
	  }
	  public void setOperTime(Date operTime) {
	  	this.operTime = operTime;
	  }
	  @Override
	  public String toString() {
	  	return "IdxOperStepVO [idxSplitId=" + idxSplitId + ", operType=" + operType + ", desc=" + desc
	  			+ ", operDepartment=" + operDepartment + ", operator=" + operator + ", operTime=" + operTime + "]";
	  }
	
	}


​	
​	
	排序 1	
	
	package com.ane56.dispatch.application;
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.util.ArrayList;
	import java.util.Collections;
	import java.util.Comparator;
	import java.util.List;
	import com.ane56.bi.domain.basic.IdxOperStepVO;
	public class AppTest {
	
		public static void main(String[] args) throws ParseException {
		// 4 2 5 1 3
		String date1 = "2018-09-10 10:49:22";
		String date2 = "2018-09-06 10:49:22";
		String date3 = "2018-09-21 10:49:22";
		String date4 = "2018-09-05 10:49:22";
		String date5 = "2018-09-10 10:40:22";
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<IdxOperStepVO> list = new ArrayList<>();
		IdxOperStepVO i1 = new IdxOperStepVO(); 
		i1.setOperType("指标名称1");
		i1.setDesc("指标名称1");
		i1.setOperDepartment("指标名称1部门");  //部门
		i1.setOperator("指标名称1人");
		i1.setOperTime(sf.parse(date1));
		
		IdxOperStepVO i2 = new IdxOperStepVO(); 
		i2.setOperType("指标名称2");
		i2.setDesc("指标名称2");
		i2.setOperDepartment("指标名称2部门");  //部门
		i2.setOperator("指标名称2人");
		i2.setOperTime(sf.parse(date2));
		
		IdxOperStepVO i3 = new IdxOperStepVO(); 
		i3.setOperType("指标名称3");
		i3.setDesc("指标名称3");
		i3.setOperDepartment("指标名称3部门");  //部门
		i3.setOperator("指标名称3人");
		i3.setOperTime(sf.parse(date3));
		
		IdxOperStepVO i4 = new IdxOperStepVO(); 
		i4.setOperType("指标名称4");
		i4.setDesc("指标名称4");
		i4.setOperDepartment("指标名称4部门");  //部门
		i4.setOperator("指标名称4人");
		i4.setOperTime(sf.parse(date4));
		
		IdxOperStepVO i5 = new IdxOperStepVO(); 
		i5.setOperType("指标名称5");
		i5.setDesc("指标名称5");
		i5.setOperDepartment("指标名称5部门");  //部门
		i5.setOperator("指标名称5人");
		i5.setOperTime(sf.parse(date5));
		list.add(i1);
		list.add(i2);
		list.add(i3);
		list.add(i4);
		list.add(i5);
		for (IdxOperStepVO idxOperStepVO : list) {
			System.err.println(idxOperStepVO);
		}
		Collections.sort(list, new Comparator<IdxOperStepVO>() {
			@Override
			public int compare(IdxOperStepVO o1, IdxOperStepVO o2) {
				if (o1.getOperTime().getTime()>o2.getOperTime().getTime()) {
					return 1;
				}
				return -1;
			}
		});
		
		System.err.println("------------------------------");
		for (IdxOperStepVO idxOperStepVO : list) {
			System.err.println(idxOperStepVO);
		}
	}
	}
	#####结果
	IdxOperStepVO [idxSplitId=null, operType=指标名称1, desc=指标名称1, operDepartment=指标名称1部门, operator=指标名称1人, operTime=Mon Sep 10 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称2, desc=指标名称2, operDepartment=指标名称2部门, operator=指标名称2人, operTime=Thu Sep 06 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称3, desc=指标名称3, operDepartment=指标名称3部门, operator=指标名称3人, operTime=Fri Sep 21 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称4, desc=指标名称4, operDepartment=指标名称4部门, operator=指标名称4人, operTime=Wed Sep 05 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称5, desc=指标名称5, operDepartment=指标名称5部门, operator=指标名称5人, operTime=Mon Sep 10 10:40:22 CST 2018]


​	
​	
​	
​	
	IdxOperStepVO [idxSplitId=null, operType=指标名称4, desc=指标名称4, operDepartment=指标名称4部门, operator=指标名称4人, operTime=Wed Sep 05 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称2, desc=指标名称2, operDepartment=指标名称2部门, operator=指标名称2人, operTime=Thu Sep 06 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称5, desc=指标名称5, operDepartment=指标名称5部门, operator=指标名称5人, operTime=Mon Sep 10 10:40:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称1, desc=指标名称1, operDepartment=指标名称1部门, operator=指标名称1人, operTime=Mon Sep 10 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称3, desc=指标名称3, operDepartment=指标名称3部门, operator=指标名称3人, operTime=Fri Sep 21 10:49:22 CST 2018]


###### 方式2  实现Comparable接口	

	VO
	package com.ane56.bi.domain.basic;
	
	import java.util.Date;
	
	/**
	 * @author huliangjun
	 * @date 2018-07-27 17:57:49 全流程查看VO
	 *
	 */
	public class IdxOperStepVO implements Comparable<IdxOperStepVO>{
	
		private String idxSplitId;
		private String operType;
		private String desc;
		private String operDepartment;
		private String operator;
		private Date operTime;
	
		public IdxOperStepVO() {
			super();
		}
	
		public IdxOperStepVO(String idxSplitId, String operType, String desc, String operDepartment, String operator,
				Date operTime) {
			super();
			this.idxSplitId = idxSplitId;
			this.operType = operType;
			this.desc = desc;
			this.operDepartment = operDepartment;
			this.operator = operator;
			this.operTime = operTime;
		}
	
		public String getIdxSplitId() {
			return idxSplitId;
		}
	
		public void setIdxSplitId(String idxSplitId) {
			this.idxSplitId = idxSplitId;
		}
	
		public String getOperType() {
			return operType;
		}
	
		public void setOperType(String operType) {
			this.operType = operType;
		}
	
		public String getDesc() {
			return desc;
		}
	
		public void setDesc(String desc) {
			this.desc = desc;
		}
	
		public String getOperDepartment() {
			return operDepartment;
		}
	
		public void setOperDepartment(String operDepartment) {
			this.operDepartment = operDepartment;
		}
	
		public String getOperator() {
			return operator;
		}
	
		public void setOperator(String operator) {
			this.operator = operator;
		}
	
		public Date getOperTime() {
			return operTime;
		}
	
		public void setOperTime(Date operTime) {
			this.operTime = operTime;
		}
	
		@Override
		public String toString() {
			return "IdxOperStepVO [idxSplitId=" + idxSplitId + ", operType=" + operType + ", desc=" + desc
					+ ", operDepartment=" + operDepartment + ", operator=" + operator + ", operTime=" + operTime + "]";
		}
	
		@Override
		public int compareTo(IdxOperStepVO o) {
			if (this.operTime.getTime()>o.getOperTime().getTime()) {
				return 1;
			}
			if (this.operTime.getTime()<o.getOperTime().getTime()) {
				return -1;
			}
			return 0;
		}
	
	}
	
	#####测试
	package com.ane56.dispatch.application;
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.util.ArrayList;
	import java.util.Collections;
	import java.util.Comparator;
	import java.util.List;
	import com.ane56.bi.domain.basic.IdxOperStepVO;
	public class AppTest {
		public static void main(String[] args) throws ParseException {
			// 4 2 5 1 3
			String date1 = "2018-09-10 10:49:22";
			String date2 = "2018-09-06 10:49:22";
			String date3 = "2018-09-21 10:49:22";
			String date4 = "2018-09-05 10:49:22";
			String date5 = "2018-09-10 10:40:22";
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<IdxOperStepVO> list = new ArrayList<>();
		IdxOperStepVO i1 = new IdxOperStepVO(); 
		i1.setOperType("指标名称1");
		i1.setDesc("指标名称1");
		i1.setOperDepartment("指标名称1部门");  //部门
		i1.setOperator("指标名称1人");
		i1.setOperTime(sf.parse(date1));
		
		IdxOperStepVO i2 = new IdxOperStepVO(); 
		i2.setOperType("指标名称2");
		i2.setDesc("指标名称2");
		i2.setOperDepartment("指标名称2部门");  //部门
		i2.setOperator("指标名称2人");
		i2.setOperTime(sf.parse(date2));
		
		IdxOperStepVO i3 = new IdxOperStepVO(); 
		i3.setOperType("指标名称3");
		i3.setDesc("指标名称3");
		i3.setOperDepartment("指标名称3部门");  //部门
		i3.setOperator("指标名称3人");
		i3.setOperTime(sf.parse(date3));
		
		IdxOperStepVO i4 = new IdxOperStepVO(); 
		i4.setOperType("指标名称4");
		i4.setDesc("指标名称4");
		i4.setOperDepartment("指标名称4部门");  //部门
		i4.setOperator("指标名称4人");
		i4.setOperTime(sf.parse(date4));
		
		IdxOperStepVO i5 = new IdxOperStepVO(); 
		i5.setOperType("指标名称5");
		i5.setDesc("指标名称5");
		i5.setOperDepartment("指标名称5部门");  //部门
		i5.setOperator("指标名称5人");
		i5.setOperTime(sf.parse(date5));
		list.add(i1);
		list.add(i2);
		list.add(i3);
		list.add(i4);
		list.add(i5);
		for (IdxOperStepVO idxOperStepVO : list) {
			System.err.println(idxOperStepVO);
		}
		//		Collections.sort(list, new Comparator<IdxOperStepVO>() {
	//
	//			@Override
	//			public int compare(IdxOperStepVO o1, IdxOperStepVO o2) {
	//				if (o1.getOperTime().getTime()>o2.getOperTime().getTime()) {
	//					return 1;
	//				}
	//				return -1;
	//			}
	//		});
			 Collections.sort(list);
			System.err.println("------------------------------");
			for (IdxOperStepVO idxOperStepVO : list) {
				System.err.println(idxOperStepVO);
			}
		}
	}


​	
​	
	IdxOperStepVO [idxSplitId=null, operType=指标名称1, desc=指标名称1, operDepartment=指标名称1部门, operator=指标名称1人, operTime=Mon Sep 10 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称2, desc=指标名称2, operDepartment=指标名称2部门, operator=指标名称2人, operTime=Thu Sep 06 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称3, desc=指标名称3, operDepartment=指标名称3部门, operator=指标名称3人, operTime=Fri Sep 21 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称4, desc=指标名称4, operDepartment=指标名称4部门, operator=指标名称4人, operTime=Wed Sep 05 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称5, desc=指标名称5, operDepartment=指标名称5部门, operator=指标名称5人, operTime=Mon Sep 10 10:40:22 CST 2018]
	------------------------------
	IdxOperStepVO [idxSplitId=null, operType=指标名称4, desc=指标名称4, operDepartment=指标名称4部门, operator=指标名称4人, operTime=Wed Sep 05 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称2, desc=指标名称2, operDepartment=指标名称2部门, operator=指标名称2人, operTime=Thu Sep 06 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称5, desc=指标名称5, operDepartment=指标名称5部门, operator=指标名称5人, operTime=Mon Sep 10 10:40:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称1, desc=指标名称1, operDepartment=指标名称1部门, operator=指标名称1人, operTime=Mon Sep 10 10:49:22 CST 2018]
	IdxOperStepVO [idxSplitId=null, operType=指标名称3, desc=指标名称3, operDepartment=指标名称3部门, operator=指标名称3人, operTime=Fri Sep 21 10:49:22 CST 2018]


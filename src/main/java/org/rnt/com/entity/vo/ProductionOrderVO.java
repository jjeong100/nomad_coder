package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductionOrderVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 1923371856134293280L;
    private String factoryCd;
    private String prodSeq;
    private String prodPoNo;
    private String prodWaNo;
    private String ordDt;
    private String ordCd;
    private String ordNm;
    private Integer orderQty;
    private String prodTypeCd;
    private String prodTypeNm;
    private String prodBigo;
    private String prodStdt;
    private String poCalldt;
    private String poTargetdt;
    private String itemCd;
    private String itemNm;
    private String bomVer;
    private String bomStdt;
    private String operCd;
    private String operNm;
    private String operSeq;
    private String custCd;
    private String custNm;
    private String itemNo;
    private String itemKind;
    private Integer poQty;
    private Integer poOrd;
    private Integer actokQty;
    private Integer actbadQty;
    private String mdDelidt;
    private String prodDt;
    private String useYn;
    private java.util.Date writeDt;
    private String writeId;
    private java.util.Date updateDt;
    private String updateId;
    // add
    private String searchProdPoNo;
    private String workstDt;
    private String workedDt;
    private String searchCustCd;
    private String searchItemCd;

    private String searchIdx;
    private Integer actokSumQty;
    private String mqcSeq;
    private Double useCheckQty;
    private Integer remActokQty;
    private Integer remEquipQty;

    private Integer equipQty;
    private String workactSeq;
    private String qmStockQty;
    private Integer lastDay;

    private String searchNotProdTypeCd;
    private String searchPoCalldt;
    private String searchProdSeq;
    private String workactdSeq;

    private String day1 ;
    private String day2 ;
    private String day3 ;
    private String day4 ;
    private String day5 ;
    private String day6 ;
    private String day7 ;
    private String day8 ;
    private String day9 ;
    private String day10;
    private String day11;
    private String day12;
    private String day13;
    private String day14;
    private String day15;
    private String day16;
    private String day17;
    private String day18;
    private String day19;
    private String day20;
    private String day21;
    private String day22;
    private String day23;
    private String day24;
    private String day25;
    private String day26;
    private String day27;
    private String day28;
    private String day29;
    private String day30;
    private String day31;
    private String demandQty;

	public String getDemandQty() {
		return demandQty;
	}
	public void setDemandQty(String demandQty) {
		this.demandQty = demandQty;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public void setProdSeq(String prodSeq) {
		this.prodSeq = prodSeq;
	}
	public String getProdPoNo() {
		return prodPoNo;
	}
	public void setProdPoNo(String prodPoNo) {
		this.prodPoNo = prodPoNo;
	}
	public String getProdWaNo() {
		return prodWaNo;
	}
	public void setProdWaNo(String prodWaNo) {
		this.prodWaNo = prodWaNo;
	}
	public String getOrdDt() {
		return ordDt;
	}
	public void setOrdDt(String ordDt) {
		this.ordDt = ordDt;
	}
	public String getOrdCd() {
		return ordCd;
	}
	public void setOrdCd(String ordCd) {
		this.ordCd = ordCd;
	}
	public String getOrdNm() {
		return ordNm;
	}
	public void setOrdNm(String ordNm) {
		this.ordNm = ordNm;
	}
	public Integer getOrderQty() {
		return orderQty;
	}
	public void setOrderQty(Integer orderQty) {
		this.orderQty = orderQty;
	}
	public String getProdTypeCd() {
		return prodTypeCd;
	}
	public void setProdTypeCd(String prodTypeCd) {
		this.prodTypeCd = prodTypeCd;
	}
	public String getProdTypeNm() {
		return prodTypeNm;
	}
	public void setProdTypeNm(String prodTypeNm) {
		this.prodTypeNm = prodTypeNm;
	}
	public String getProdBigo() {
		return prodBigo;
	}
	public void setProdBigo(String prodBigo) {
		this.prodBigo = prodBigo;
	}
	public String getProdStdt() {
		return prodStdt;
	}
	public void setProdStdt(String prodStdt) {
		this.prodStdt = prodStdt;
	}
	public String getPoCalldt() {
		return poCalldt;
	}
	public void setPoCalldt(String poCalldt) {
		this.poCalldt = poCalldt;
	}
	public String getPoTargetdt() {
		return poTargetdt;
	}
	public void setPoTargetdt(String poTargetdt) {
		this.poTargetdt = poTargetdt;
	}
	public String getItemCd() {
		return itemCd;
	}
	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}
	public String getItemNm() {
		return itemNm;
	}
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	public String getBomVer() {
		return bomVer;
	}
	public void setBomVer(String bomVer) {
		this.bomVer = bomVer;
	}
	public String getBomStdt() {
		return bomStdt;
	}
	public void setBomStdt(String bomStdt) {
		this.bomStdt = bomStdt;
	}
	public String getOperCd() {
		return operCd;
	}
	public void setOperCd(String operCd) {
		this.operCd = operCd;
	}
	public String getOperNm() {
		return operNm;
	}
	public void setOperNm(String operNm) {
		this.operNm = operNm;
	}
	public String getOperSeq() {
		return operSeq;
	}
	public void setOperSeq(String operSeq) {
		this.operSeq = operSeq;
	}
	public String getCustCd() {
		return custCd;
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getItemKind() {
		return itemKind;
	}
	public void setItemKind(String itemKind) {
		this.itemKind = itemKind;
	}
	public Integer getPoQty() {
		return poQty;
	}
	public void setPoQty(Integer poQty) {
		this.poQty = poQty;
	}
	public Integer getPoOrd() {
		return poOrd;
	}
	public void setPoOrd(Integer poOrd) {
		this.poOrd = poOrd;
	}
	public Integer getActokQty() {
		return actokQty;
	}
	public void setActokQty(Integer actokQty) {
		this.actokQty = actokQty;
	}
	public Integer getActbadQty() {
		return actbadQty;
	}
	public void setActbadQty(Integer actbadQty) {
		this.actbadQty = actbadQty;
	}
	public String getMdDelidt() {
		return mdDelidt;
	}
	public void setMdDelidt(String mdDelidt) {
		this.mdDelidt = mdDelidt;
	}
	public String getProdDt() {
		return prodDt;
	}
	public void setProdDt(String prodDt) {
		this.prodDt = prodDt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public java.util.Date getWriteDt() {
		return writeDt;
	}
	public void setWriteDt(java.util.Date writeDt) {
		this.writeDt = writeDt;
	}
	public String getWriteId() {
		return writeId;
	}
	public void setWriteId(String writeId) {
		this.writeId = writeId;
	}
	public java.util.Date getUpdateDt() {
		return updateDt;
	}
	public void setUpdateDt(java.util.Date updateDt) {
		this.updateDt = updateDt;
	}
	public String getUpdateId() {
		return updateId;
	}
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	public String getSearchProdPoNo() {
		return searchProdPoNo;
	}
	public void setSearchProdPoNo(String searchProdPoNo) {
		this.searchProdPoNo = searchProdPoNo;
	}
	public String getWorkstDt() {
		return workstDt;
	}
	public void setWorkstDt(String workstDt) {
		this.workstDt = workstDt;
	}
	public String getWorkedDt() {
		return workedDt;
	}
	public void setWorkedDt(String workedDt) {
		this.workedDt = workedDt;
	}
	public String getSearchCustCd() {
		return searchCustCd;
	}
	public void setSearchCustCd(String searchCustCd) {
		this.searchCustCd = searchCustCd;
	}
	public String getSearchItemCd() {
		return searchItemCd;
	}
	public void setSearchItemCd(String searchItemCd) {
		this.searchItemCd = searchItemCd;
	}
	public String getSearchIdx() {
		return searchIdx;
	}
	public void setSearchIdx(String searchIdx) {
		this.searchIdx = searchIdx;
	}
	public Integer getActokSumQty() {
		return actokSumQty;
	}
	public void setActokSumQty(Integer actokSumQty) {
		this.actokSumQty = actokSumQty;
	}
	public String getMqcSeq() {
		return mqcSeq;
	}
	public void setMqcSeq(String mqcSeq) {
		this.mqcSeq = mqcSeq;
	}
	public Double getUseCheckQty() {
		return useCheckQty;
	}
	public void setUseCheckQty(Double useCheckQty) {
		this.useCheckQty = useCheckQty;
	}
	public Integer getRemActokQty() {
		return remActokQty;
	}
	public void setRemActokQty(Integer remActokQty) {
		this.remActokQty = remActokQty;
	}
	public Integer getRemEquipQty() {
		return remEquipQty;
	}
	public void setRemEquipQty(Integer remEquipQty) {
		this.remEquipQty = remEquipQty;
	}
	public Integer getEquipQty() {
		return equipQty;
	}
	public void setEquipQty(Integer equipQty) {
		this.equipQty = equipQty;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getQmStockQty() {
		return qmStockQty;
	}
	public void setQmStockQty(String qmStockQty) {
		this.qmStockQty = qmStockQty;
	}
	public Integer getLastDay() {
		return lastDay;
	}
	public void setLastDay(Integer lastDay) {
		this.lastDay = lastDay;
	}
	public String getSearchNotProdTypeCd() {
		return searchNotProdTypeCd;
	}
	public void setSearchNotProdTypeCd(String searchNotProdTypeCd) {
		this.searchNotProdTypeCd = searchNotProdTypeCd;
	}
	public String getSearchPoCalldt() {
		return searchPoCalldt;
	}
	public void setSearchPoCalldt(String searchPoCalldt) {
		this.searchPoCalldt = searchPoCalldt;
	}
	public String getSearchProdSeq() {
		return searchProdSeq;
	}
	public void setSearchProdSeq(String searchProdSeq) {
		this.searchProdSeq = searchProdSeq;
	}
	public String getWorkactdSeq() {
		return workactdSeq;
	}
	public void setWorkactdSeq(String workactdSeq) {
		this.workactdSeq = workactdSeq;
	}
	public String getDay1() {
		return day1;
	}
	public void setDay1(String day1) {
		this.day1 = day1;
	}
	public String getDay2() {
		return day2;
	}
	public void setDay2(String day2) {
		this.day2 = day2;
	}
	public String getDay3() {
		return day3;
	}
	public void setDay3(String day3) {
		this.day3 = day3;
	}
	public String getDay4() {
		return day4;
	}
	public void setDay4(String day4) {
		this.day4 = day4;
	}
	public String getDay5() {
		return day5;
	}
	public void setDay5(String day5) {
		this.day5 = day5;
	}
	public String getDay6() {
		return day6;
	}
	public void setDay6(String day6) {
		this.day6 = day6;
	}
	public String getDay7() {
		return day7;
	}
	public void setDay7(String day7) {
		this.day7 = day7;
	}
	public String getDay8() {
		return day8;
	}
	public void setDay8(String day8) {
		this.day8 = day8;
	}
	public String getDay9() {
		return day9;
	}
	public void setDay9(String day9) {
		this.day9 = day9;
	}
	public String getDay10() {
		return day10;
	}
	public void setDay10(String day10) {
		this.day10 = day10;
	}
	public String getDay11() {
		return day11;
	}
	public void setDay11(String day11) {
		this.day11 = day11;
	}
	public String getDay12() {
		return day12;
	}
	public void setDay12(String day12) {
		this.day12 = day12;
	}
	public String getDay13() {
		return day13;
	}
	public void setDay13(String day13) {
		this.day13 = day13;
	}
	public String getDay14() {
		return day14;
	}
	public void setDay14(String day14) {
		this.day14 = day14;
	}
	public String getDay15() {
		return day15;
	}
	public void setDay15(String day15) {
		this.day15 = day15;
	}
	public String getDay16() {
		return day16;
	}
	public void setDay16(String day16) {
		this.day16 = day16;
	}
	public String getDay17() {
		return day17;
	}
	public void setDay17(String day17) {
		this.day17 = day17;
	}
	public String getDay18() {
		return day18;
	}
	public void setDay18(String day18) {
		this.day18 = day18;
	}
	public String getDay19() {
		return day19;
	}
	public void setDay19(String day19) {
		this.day19 = day19;
	}
	public String getDay20() {
		return day20;
	}
	public void setDay20(String day20) {
		this.day20 = day20;
	}
	public String getDay21() {
		return day21;
	}
	public void setDay21(String day21) {
		this.day21 = day21;
	}
	public String getDay22() {
		return day22;
	}
	public void setDay22(String day22) {
		this.day22 = day22;
	}
	public String getDay23() {
		return day23;
	}
	public void setDay23(String day23) {
		this.day23 = day23;
	}
	public String getDay24() {
		return day24;
	}
	public void setDay24(String day24) {
		this.day24 = day24;
	}
	public String getDay25() {
		return day25;
	}
	public void setDay25(String day25) {
		this.day25 = day25;
	}
	public String getDay26() {
		return day26;
	}
	public void setDay26(String day26) {
		this.day26 = day26;
	}
	public String getDay27() {
		return day27;
	}
	public void setDay27(String day27) {
		this.day27 = day27;
	}
	public String getDay28() {
		return day28;
	}
	public void setDay28(String day28) {
		this.day28 = day28;
	}
	public String getDay29() {
		return day29;
	}
	public void setDay29(String day29) {
		this.day29 = day29;
	}
	public String getDay30() {
		return day30;
	}
	public void setDay30(String day30) {
		this.day30 = day30;
	}
	public String getDay31() {
		return day31;
	}
	public void setDay31(String day31) {
		this.day31 = day31;
	}
}

package org.rnt.com.entity.vo;

import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class ProductionActVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 4161687754026731743L;
	private String factoryCd;
	private String workactSeq;
	private String prodWaNo;
	private String prodSeq;
	private String prodPoNo;
	private String operCd;
	private String operNm;
	private String operSeq;
	private Integer bomLevel;
	private String itemCd;
	private String itemNm;
	private String bomVer;
	private String bomStdt;
	private String outcustYn;
	private String workDt;
	private String workstDt;
	private String workedDt;
	private String prodTypeCd;
	private String prodTypeNm;
	private String sabunId;
	private String sabunNm;
	private Integer poQty;
	private Integer actokQty;
	private Integer actbadQty;
	private String badCd;
	private Integer actbadMetalQty;
	private Integer actbadUnderQty;
	private Integer actbadViewQty;
	private Integer residueQty;
	private String badNm;
	private String workactBigo;
	private String confirmYn;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String equipNm;
	private String equipCd;
	// add
	private String searchProdSeq;
	private String searchOperCd;
	private String shortId;
	private String poCalldt;
	private String plcClearMsg;
	private String workstHour;
	private String workedHour;

	private Integer remEquipQty;

	private String searchIdx;
	private String searchEquipPg;
	private String searchProdTypeCd;
	private String preProdTypeCd;

	private String performanceTypeCd1;
	private String performanceTypeCd2;
	private String performanceTypeCd3;
	private String performanceTypeCd4;
	private String performanceTypeCd5;

	private String workactPerformanceSeq;
	private String workactBadSeq;
	private String lastOperYn;

	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getWorkactSeq() {
		return workactSeq;
	}
	public void setWorkactSeq(String workactSeq) {
		this.workactSeq = workactSeq;
	}
	public String getProdWaNo() {
		return prodWaNo;
	}
	public void setProdWaNo(String prodWaNo) {
		this.prodWaNo = prodWaNo;
	}
	public String getProdSeq() {
		return prodSeq;
	}
	public String getEquipNm() {
		return equipNm;
	}
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
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
	public Integer getBomLevel() {
		return bomLevel;
	}
	public void setBomLevel(Integer bomLevel) {
		this.bomLevel = bomLevel;
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
	public String getOutcustYn() {
		return outcustYn;
	}
	public void setOutcustYn(String outcustYn) {
		this.outcustYn = outcustYn;
	}
	public String getWorkDt() {
		return workDt;
	}
	public void setWorkDt(String workDt) {
		this.workDt = workDt;
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
	public String getSabunId() {
		return sabunId;
	}
	public void setSabunId(String sabunId) {
		this.sabunId = sabunId;
	}
	public String getSabunNm() {
		return sabunNm;
	}
	public void setSabunNm(String sabunNm) {
		this.sabunNm = sabunNm;
	}
	public Integer getPoQty() {
		return poQty;
	}
	public void setPoQty(Integer poQty) {
		this.poQty = poQty;
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
	public String getBadCd() {
		return badCd;
	}
	public void setBadCd(String badCd) {
		this.badCd = badCd;
	}
	public Integer getActbadMetalQty() {
		return actbadMetalQty;
	}
	public void setActbadMetalQty(Integer actbadMetalQty) {
		this.actbadMetalQty = actbadMetalQty;
	}
	public Integer getActbadUnderQty() {
		return actbadUnderQty;
	}
	public void setActbadUnderQty(Integer actbadUnderQty) {
		this.actbadUnderQty = actbadUnderQty;
	}
	public Integer getActbadViewQty() {
		return actbadViewQty;
	}
	public void setActbadViewQty(Integer actbadViewQty) {
		this.actbadViewQty = actbadViewQty;
	}
	public Integer getResidueQty() {
		return residueQty;
	}
	public void setResidueQty(Integer residueQty) {
		this.residueQty = residueQty;
	}
	public String getBadNm() {
		return badNm;
	}
	public void setBadNm(String badNm) {
		this.badNm = badNm;
	}
	public String getWorkactBigo() {
		return workactBigo;
	}
	public void setWorkactBigo(String workactBigo) {
		this.workactBigo = workactBigo;
	}
	public String getConfirmYn() {
		return confirmYn;
	}
	public void setConfirmYn(String confirmYn) {
		this.confirmYn = confirmYn;
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
	public String getSearchProdSeq() {
		return searchProdSeq;
	}
	public void setSearchProdSeq(String searchProdSeq) {
		this.searchProdSeq = searchProdSeq;
	}
	public String getSearchOperCd() {
		return searchOperCd;
	}
	public void setSearchOperCd(String searchOperCd) {
		this.searchOperCd = searchOperCd;
	}
	public String getShortId() {
		return shortId;
	}
	public void setShortId(String shortId) {
		this.shortId = shortId;
	}
	public String getPoCalldt() {
		return poCalldt;
	}
	public void setPoCalldt(String poCalldt) {
		this.poCalldt = poCalldt;
	}
	public String getPlcClearMsg() {
		return plcClearMsg;
	}
	public void setPlcClearMsg(String plcClearMsg) {
		this.plcClearMsg = plcClearMsg;
	}
	public String getWorkstHour() {
		return workstHour;
	}
	public void setWorkstHour(String workstHour) {
		this.workstHour = workstHour;
	}
	public String getWorkedHour() {
		return workedHour;
	}
	public void setWorkedHour(String workedHour) {
		this.workedHour = workedHour;
	}
	public Integer getRemEquipQty() {
		return remEquipQty;
	}
	public void setRemEquipQty(Integer remEquipQty) {
		this.remEquipQty = remEquipQty;
	}
	public String getSearchIdx() {
		return searchIdx;
	}
	public void setSearchIdx(String searchIdx) {
		this.searchIdx = searchIdx;
	}
	public String getSearchEquipPg() {
		return searchEquipPg;
	}
	public void setSearchEquipPg(String searchEquipPg) {
		this.searchEquipPg = searchEquipPg;
	}
	public String getSearchProdTypeCd() {
		return searchProdTypeCd;
	}
	public void setSearchProdTypeCd(String searchProdTypeCd) {
		this.searchProdTypeCd = searchProdTypeCd;
	}
	public String getPreProdTypeCd() {
		return preProdTypeCd;
	}
	public void setPreProdTypeCd(String preProdTypeCd) {
		this.preProdTypeCd = preProdTypeCd;
	}
	public String getPerformanceTypeCd1() {
		return performanceTypeCd1;
	}
	public void setPerformanceTypeCd1(String performanceTypeCd1) {
		this.performanceTypeCd1 = performanceTypeCd1;
	}
	public String getPerformanceTypeCd2() {
		return performanceTypeCd2;
	}
	public void setPerformanceTypeCd2(String performanceTypeCd2) {
		this.performanceTypeCd2 = performanceTypeCd2;
	}
	public String getPerformanceTypeCd3() {
		return performanceTypeCd3;
	}
	public void setPerformanceTypeCd3(String performanceTypeCd3) {
		this.performanceTypeCd3 = performanceTypeCd3;
	}
	public String getPerformanceTypeCd4() {
		return performanceTypeCd4;
	}
	public void setPerformanceTypeCd4(String performanceTypeCd4) {
		this.performanceTypeCd4 = performanceTypeCd4;
	}
	public String getPerformanceTypeCd5() {
		return performanceTypeCd5;
	}
	public void setPerformanceTypeCd5(String performanceTypeCd5) {
		this.performanceTypeCd5 = performanceTypeCd5;
	}
	public String getWorkactPerformanceSeq() {
		return workactPerformanceSeq;
	}
	public void setWorkactPerformanceSeq(String workactPerformanceSeq) {
		this.workactPerformanceSeq = workactPerformanceSeq;
	}
	public String getWorkactBadSeq() {
		return workactBadSeq;
	}
	public void setWorkactBadSeq(String workactBadSeq) {
		this.workactBadSeq = workactBadSeq;
	}
	public String getLastOperYn() {
		return lastOperYn;
	}
	public void setLastOperYn(String lastOperYn) {
		this.lastOperYn = lastOperYn;
	}
}

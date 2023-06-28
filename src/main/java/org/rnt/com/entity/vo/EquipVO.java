package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 678235078807995081L;
	private String factoryCd;
	private String equipSeq;
	private String equipCd;
	private String equipTypeCd;
    private String equipMinSeq;

	private String equipNo;
	private String equipNm;
	private String equipPg;
	private String equipModelNo;
	private String equipCorpNm;
	private String equipGetDt;
	private String equipIp;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	private String searchEquipNo;
	private String searchEquipNm;
	private String searchEquipPg;
	private String searchEquipTypeNm;
	private String equipModelNm;
	private String equipStandard;
	private String equipMngCustNm;
    private String equipMngTelNo;
    private String equipMngNm;
    private String equipImageNm;
    private String equipImageData;


	private String equipTypeNm;
	private String equipHisSeq;
	private String equipDt;
	private String equipCont;
	private String plcYn;



	public String getEquipMinSeq() {
		return equipMinSeq;
	}
	public void setEquipMinSeq(String equipMinSeq) {
		this.equipMinSeq = equipMinSeq;
	}
	public String getPlcYn() {
		return plcYn;
	}
	public void setPlcYn(String plcYn) {
		this.plcYn = plcYn;
	}
	public String getEquipModelNm() {
		return equipModelNm;
	}
	public void setEquipModelNm(String equipModelNm) {
		this.equipModelNm = equipModelNm;
	}
	public String getEquipStandard() {
		return equipStandard;
	}
	public void setEquipStandard(String equipStandard) {
		this.equipStandard = equipStandard;
	}
	public String getEquipMngCustNm() {
		return equipMngCustNm;
	}
	public void setEquipMngCustNm(String equipMngCustNm) {
		this.equipMngCustNm = equipMngCustNm;
	}
	public String getEquipMngTelNo() {
		return equipMngTelNo;
	}
	public void setEquipMngTelNo(String equipMngTelNo) {
		this.equipMngTelNo = equipMngTelNo;
	}
	public String getEquipMngNm() {
		return equipMngNm;
	}
	public void setEquipMngNm(String equipMngNm) {
		this.equipMngNm = equipMngNm;
	}
	public String getEquipImageNm() {
		return equipImageNm;
	}
	public void setEquipImageNm(String equipImageNm) {
		this.equipImageNm = equipImageNm;
	}
	public String getEquipImageData() {
		return equipImageData;
	}
	public void setEquipImageData(String equipImageData) {
		this.equipImageData = equipImageData;
	}
	public String getEquipTypeNm() {
		return equipTypeNm;
	}
	public void setEquipTypeNm(String equipTypeNm) {
		this.equipTypeNm = equipTypeNm;
	}
	public String getSearchEquipTypeNm() {
		return searchEquipTypeNm;
	}
	public void setSearchEquipTypeNm(String searchEquipTypeNm) {
		this.searchEquipTypeNm = searchEquipTypeNm;
	}
	public String getEquipTypeCd() {
		return equipTypeCd;
	}
	public void setEquipTypeCd(String equipTypeCd) {
		this.equipTypeCd = equipTypeCd;
	}
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getEquipSeq() {
		return equipSeq;
	}
	public void setEquipSeq(String equipSeq) {
		this.equipSeq = equipSeq;
	}
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public String getEquipNo() {
		return equipNo;
	}
	public void setEquipNo(String equipNo) {
		this.equipNo = equipNo;
	}
	public String getEquipNm() {
		return equipNm;
	}
	public void setEquipNm(String equipNm) {
		this.equipNm = equipNm;
	}
	public String getEquipPg() {
		return equipPg;
	}
	public void setEquipPg(String equipPg) {
		this.equipPg = equipPg;
	}
	public String getEquipModelNo() {
		return equipModelNo;
	}
	public void setEquipModelNo(String equipModelNo) {
		this.equipModelNo = equipModelNo;
	}
	public String getEquipCorpNm() {
		return equipCorpNm;
	}
	public void setEquipCorpNm(String equipCorpNm) {
		this.equipCorpNm = equipCorpNm;
	}
	public String getEquipGetDt() {
		return equipGetDt;
	}
	public void setEquipGetDt(String equipGetDt) {
		this.equipGetDt = equipGetDt;
	}
	public String getEquipIp() {
		return equipIp;
	}
	public void setEquipIp(String equipIp) {
		this.equipIp = equipIp;
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
	public String getSearchEquipNo() {
		return searchEquipNo;
	}
	public void setSearchEquipNo(String searchEquipNo) {
		this.searchEquipNo = searchEquipNo;
	}
	public String getSearchEquipNm() {
		return searchEquipNm;
	}
	public void setSearchEquipNm(String searchEquipNm) {
		this.searchEquipNm = searchEquipNm;
	}
	public String getSearchEquipPg() {
		return searchEquipPg;
	}
	public void setSearchEquipPg(String searchEquipPg) {
		this.searchEquipPg = searchEquipPg;
	}
	public String getEquipHisSeq() {
		return equipHisSeq;
	}
	public void setEquipHisSeq(String equipHisSeq) {
		this.equipHisSeq = equipHisSeq;
	}
	public String getEquipDt() {
		return equipDt;
	}
	public void setEquipDt(String equipDt) {
		this.equipDt = equipDt;
	}
	public String getEquipCont() {
		return equipCont;
	}
	public void setEquipCont(String equipCont) {
		this.equipCont = equipCont;
	}

}

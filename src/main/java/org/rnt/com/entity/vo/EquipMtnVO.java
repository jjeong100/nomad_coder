package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class EquipMtnVO extends SearchDefaultVO implements Serializable {
	private static final long serialVersionUID = -9062341649408999290L;
	private String factoryCd;
	private String equipSeq;
	private String equipMtnSeq;
	private String equipChkDt;
	private String equipChkCont;
	private String equipEtc;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	private String searchEquipNm;
	private String searchEquipSeq;
	private String searchEquipChkDt;

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

	public String getEquipMtnSeq() {
		return equipMtnSeq;
	}
	public void setEquipMtnSeq(String equipMtnSeq) {
		this.equipMtnSeq = equipMtnSeq;
	}
	public String getEquipChkDt() {
		return equipChkDt;
	}
	public void setEquipChkDt(String equipChkDt) {
		this.equipChkDt = equipChkDt;
	}
	public String getEquipChkCont() {
		return equipChkCont;
	}
	public void setEquipChkCont(String equipChkCont) {
		this.equipChkCont = equipChkCont;
	}
	public String getEquipEtc() {
		return equipEtc;
	}
	public void setEquipEtc(String equipEtc) {
		this.equipEtc = equipEtc;
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
	public String getSearchEquipNm() {
		return searchEquipNm;
	}
	public void setSearchEquipNm(String searchEquipNm) {
		this.searchEquipNm = searchEquipNm;
	}
	public String getSearchEquipSeq() {
		return searchEquipSeq;
	}
	public void setSearchEquipSeq(String searchEquipSeq) {
		this.searchEquipSeq = searchEquipSeq;
	}
	public String getSearchEquipChkDt() {
		return searchEquipChkDt;
	}
	public void setSearchEquipChkDt(String searchEquipChkDt) {
		this.searchEquipChkDt = searchEquipChkDt;
	}

}

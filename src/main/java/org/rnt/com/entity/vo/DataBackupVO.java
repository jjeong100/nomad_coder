package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DataBackupVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 5121767777587384113L;
	private String factoryCd;
	private String backupSeq;
	private String backupNm;
	private String backupPath;
	private String backupDt;
	private String backupDivNm;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;

	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getBackupSeq() {
		return backupSeq;
	}
	public void setBackupSeq(String backupSeq) {
		this.backupSeq = backupSeq;
	}
	public String getBackupNm() {
		return backupNm;
	}
	public void setBackupNm(String backupNm) {
		this.backupNm = backupNm;
	}
	public String getBackupPath() {
		return backupPath;
	}
	public void setBackupPath(String backupPath) {
		this.backupPath = backupPath;
	}
	public String getBackupDt() {
		return backupDt;
	}
	public void setBackupDt(String backupDt) {
		this.backupDt = backupDt;
	}
	public String getBackupDivNm() {
		return backupDivNm;
	}
	public void setBackupDivNm(String backupDivNm) {
		this.backupDivNm = backupDivNm;
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
}

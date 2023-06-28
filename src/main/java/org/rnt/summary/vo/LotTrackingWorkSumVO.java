package org.rnt.summary.vo;
import java.io.Serializable;

public class LotTrackingWorkSumVO extends LotTrackingVO implements Serializable {
	static final long serialVersionUID = 6216375338911013782L;
	
	private String workDt;
	private String operNm;
	private String sabunNm;
	private String workstDt;
	private String workedDt;
	private String equipCd;
	private String actokQty;
	private String actbadQty;
	private String equipNm;
	
	public String getEquipNm() {
        return equipNm;
    }
    public void setEquipNm(String equipNm) {
        this.equipNm = equipNm;
    }
    public String getWorkDt() {
		return workDt;
	}
	public void setWorkDt(String workDt) {
		this.workDt = workDt;
	}
	public String getOperNm() {
		return operNm;
	}
	public void setOperNm(String operNm) {
		this.operNm = operNm;
	}
	public String getSabunNm() {
		return sabunNm;
	}
	public void setSabunNm(String sabunNm) {
		this.sabunNm = sabunNm;
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
	public String getEquipCd() {
		return equipCd;
	}
	public void setEquipCd(String equipCd) {
		this.equipCd = equipCd;
	}
	public String getActokQty() {
		return actokQty;
	}
	public void setActokQty(String actokQty) {
		this.actokQty = actokQty;
	}
	public String getActbadQty() {
		return actbadQty;
	}
	public void setActbadQty(String actbadQty) {
		this.actbadQty = actbadQty;
	}
	
}

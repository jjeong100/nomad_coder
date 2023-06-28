package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class DeviceVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 5500604166501255671L;
	private String factoryCd;
	private String deviceCd;
	private String deviceNm;
	private String deviceIp;
	private Integer devicePort;
	private String deviceBigo;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	private String searchDeviceNm;
	
	public Integer getDevicePort() {
        return devicePort;
    }
    public void setDevicePort(Integer devicePort) {
        this.devicePort = devicePort;
    }
    public String getSearchDeviceNm() {
        return searchDeviceNm;
    }
    public void setSearchDeviceNm(String searchDeviceNm) {
        this.searchDeviceNm = searchDeviceNm;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getDeviceCd() {
		return deviceCd;
	}
	public void setDeviceCd(String deviceCd) {
		this.deviceCd = deviceCd;
	}
	public String getDeviceNm() {
		return deviceNm;
	}
	public void setDeviceNm(String deviceNm) {
		this.deviceNm = deviceNm;
	}
	public String getDeviceIp() {
		return deviceIp;
	}
	public void setDeviceIp(String deviceIp) {
		this.deviceIp = deviceIp;
	}
	public String getDeviceBigo() {
		return deviceBigo;
	}
	public void setDeviceBigo(String deviceBigo) {
		this.deviceBigo = deviceBigo;
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

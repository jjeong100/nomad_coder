package org.rnt.com.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service("proPertyService")
public class ProPertyService {
   
    
    @Value("${homeUrl}")
    private String homeUrl;
    
    @Value("${mobileHomeUrl}")
    private String mobileHomeUrl;
    
    @Value("${factoryCd}")
    private String factoryCd;
    
    @Value("${Globals.print.ip}")
    private String printIp;
    
    @Value("${Globals.print.port}")
    private String printPort;
    
    @Value("${Globals.local.fileUploadPath}")
    private String localFilePath;
    
    @Value("${Globals.server.fileUploadPath}")
    private String serverFilePath;
    
    @Value("${Globals.file.maxSize}")
    private int fileMaxSize;
    
    @Value("${workshopCd}")
    private String workshopCd;
    
    @Value("${mixOperCd}")
    private String mixOperCd;
    
    @Value("${productionOperCd}")
    private String productionOperCd;
    
    @Value("${Globals.plc.ip}")
    private String plcIp;
    
    @Value("${Globals.plc.port}")
    private String plcPort;
    
    @Value("${businNo}")
    private String businNo;
    
    private String filePath;
    
    @Value("${Globals.logApi.url}")
    private String logApiUrl;
    
    @Value("${Globals.logApi.key}")
    private String logApiKey;

    
    public String getBusinNo() {
        return businNo;
    }

    public void setBusinNo(String businNo) {
        this.businNo = businNo;
    }

    public String getPlcIp() {
        return plcIp;
    }

    public void setPlcIp(String plcIp) {
        this.plcIp = plcIp;
    }

    public String getPlcPort() {
        return plcPort;
    }

    public void setPlcPort(String plcPort) {
        this.plcPort = plcPort;
    }

    public String getFilePath() {
        return filePath;
    }

    public String getMixOperCd() {
        return mixOperCd;
    }

    public void setMixOperCd(String mixOperCd) {
        this.mixOperCd = mixOperCd;
    }

    public String getProductionOperCd() {
        return productionOperCd;
    }

    public void setProductionOperCd(String productionOperCd) {
        this.productionOperCd = productionOperCd;
    }

    public String getWorkshopCd() {
        return workshopCd;
    }

    public void setWorkshopCd(String workshopCd) {
        this.workshopCd = workshopCd;
    }

    public String getMobileHomeUrl() {
        return mobileHomeUrl;
    }

    public void setMobileHomeUrl(String mobileHomeUrl) {
        this.mobileHomeUrl = mobileHomeUrl;
    }

    public String getHomeUrl() {
        return homeUrl;
    }

    public void setHomeUrl(String homeUrl) {
        this.homeUrl = homeUrl;
    }

    public String getFactoryCd() {
        return factoryCd;
    }

    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }

    public String getPrintIp() {
        return printIp;
    }

    public void setPrintIp(String printIp) {
        this.printIp = printIp;
    }

    public String getPrintPort() {
        return printPort;
    }

    public void setPrintPort(String printPort) {
        this.printPort = printPort;
    }

    public String getLocalFilePath() {
        return localFilePath;
    }

    public void setLocalFilePath(String localFilePath) {
        this.localFilePath = localFilePath;
    }

    public String getServerFilePath() {
        return serverFilePath;
    }

    public void setServerFilePath(String serverFilePath) {
        this.serverFilePath = serverFilePath;
    }

    public String getFilePath(String pathDiv) {
        if( "local".equals(pathDiv) ) {
            return localFilePath;
        } else {
            return serverFilePath;
        }
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public int getFileMaxSize() {
        return fileMaxSize;
    }

    public void setFileMaxSize(int fileMaxSize) {
        this.fileMaxSize = fileMaxSize;
    }
    
    public String getLogApiUrl() {
		return logApiUrl;
	}

	public void setLogApiUrl(String logApiUrl) {
		this.logApiUrl = logApiUrl;
	}

	public String getLogApiKey() {
		return logApiKey;
	}

	public void setLogApiKey(String logApiKey) {
		this.logApiKey = logApiKey;
	}
}

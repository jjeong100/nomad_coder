package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.CompanyInfoVO;
import org.rnt.com.vo.RtnVO;

public interface CompanyInfoService {
    public RtnVO insert(CompanyInfoVO param);
    public RtnVO select(CompanyInfoVO param);
    public RtnVO update(CompanyInfoVO param);
    public RtnVO delete(CompanyInfoVO param);
    public RtnVO searchList(CompanyInfoVO param);
    public RtnVO searchListTotCnt(CompanyInfoVO param);
}

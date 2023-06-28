package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.InspRltVO;

import org.rnt.com.vo.RtnVO;

public interface InspRltService {
    public RtnVO insert(InspRltVO param);
    public RtnVO select(InspRltVO param);
    public RtnVO update(InspRltVO param);
    public RtnVO delete(InspRltVO param);
    public RtnVO searchList(InspRltVO param);
    public RtnVO searchListTotCnt(InspRltVO param);
    public RtnVO searchInspRsltList(InspRltVO param);
    public RtnVO deleteAll(InspRltVO param);
    public RtnVO getInspDaySeq(InspRltVO param);
}

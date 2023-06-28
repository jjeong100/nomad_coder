package org.rnt.dashboard.service;

import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.vo.AutoEquipVO;

public interface AutoEquipMenuService {
    public RtnVO searchFrontAutoEquipList(AutoEquipVO param);
    public RtnVO searchFrontAutoEquipListTotCnt(AutoEquipVO param);
    public RtnVO searchRearAutoEquipList(AutoEquipVO param);
    public RtnVO searchRearAutoEquipListTotCnt(AutoEquipVO param);
    
    public RtnVO searchFrontAutoEquipSummary(AutoEquipVO param);
    public RtnVO searchFrontAutoEquipChart(AutoEquipVO param);
    public RtnVO searchRearAutoEquipSummary(AutoEquipVO param);
    public RtnVO searchRearAutoEquipChart(AutoEquipVO param);
    
    public RtnVO selectItemImage(AutoEquipVO param);
}

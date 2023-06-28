package org.rnt.com.net;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;

public class Tcp {
    private Socket sock;
    private OutputStream os = null;
    private InputStream is = null;
    private String ip;
    private Integer port;
    private String code;
    private String type;
    private String msg;
    private char carriageReturn = (char)0x0D;
    
    public Socket tpConn(String ip, int port) {
        sock = new Socket();
        try {
        	sock.setSoTimeout(5000);
            sock.connect( new InetSocketAddress(InetAddress.getByName( ip ), port ), 3000);
            this.ip = ip;
            this.port = port;
            return sock;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Socket tpConn() {
        sock = new Socket();
        try {
        	sock.setSoTimeout(10000);
            sock.connect( new InetSocketAddress(InetAddress.getByName( ip ), port ) );
            return sock;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String tpCall() {
        String out = "";
        byte[] bytes = null;
        try {
            os = sock.getOutputStream();
            System.out.println("msg"+msg);
            bytes = msg.getBytes("UTF-8");
            os.write(bytes);
            os.flush();
            
            is = sock.getInputStream();
            bytes = new byte[100];
            int readByteCount = is.read(bytes);
            out = new String(bytes,0,readByteCount,"UTF-8");
            
        } catch (Exception e) {}
        
        return out;
    }
    
    public void close() {
        try {
            os.close();
            is.close();
            sock.close();
        } catch (Exception e) {}
        
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg + carriageReturn ;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        this.port = port;
    }
    
    
}

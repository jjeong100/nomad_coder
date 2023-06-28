package org.rnt.com.util;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.net.Socket;
import java.net.UnknownHostException;


import javax.imageio.ImageIO;

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.net.util.Base64;

public class TSCPrinter {
	
	private String dataUrl;
	private String IpAdress;
	private int Port;
	private int Count;
	
	
	public TSCPrinter(String dataUrl, String ipAdress, int port, int count) {
		this.dataUrl = dataUrl;
		IpAdress = ipAdress;
		Port = port;
		Count = count;
	}


	public String getDataUrl() {
		return dataUrl;
	}


	public void setDataUrl(String dataUrl) {
		this.dataUrl = dataUrl;
	}


	public String getIpAdress() {
		return IpAdress;
	}


	public void setIpAdress(String ipAdress) {
		IpAdress = ipAdress;
	}


	public int getPort() {
		return Port;
	}


	public void setPort(int port) {
		Port = port;
	}


	public int getCount() {
		return Count;
	}


	public void setCount(int count) {
		Count = count;
	}
	
	private String str2Hex(String str) {
	    return String.format("%x", new BigInteger(1, str.getBytes()));
	}
	
	public int print() {
		System.out.println("dataUrl --->" + dataUrl);
		dataUrl = dataUrl.replace("data:image/png;base64,", "");
		byte[] byteDataUrl = Base64.decodeBase64(dataUrl);
		BufferedImage originalImage;
		ByteArrayInputStream bis = null;
		ByteArrayOutputStream baos = null;
		byte[] bitmapData = null;
		
		
		try {	
			bis = new ByteArrayInputStream(byteDataUrl);
			originalImage = ImageIO.read(bis);
			baos = new ByteArrayOutputStream();
			ImageIO.write(originalImage, "PNG", baos);
			baos.flush();
			bitmapData = baos.toByteArray();
			System.out.println("bitmapData ===>" + bitmapData.toString());
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(baos != null) {baos.close();}
					if(bis != null) {bis.close();}
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
		
		
		int result = 0;
		/*String tscFormat = str2Hex("SIZE 4,2\r\n").toUpperCase()
				+str2Hex("GAP 0,0\r\n").toUpperCase()
				+str2Hex("CLS\r\n").toUpperCase()
				+str2Hex("BITMAP 0,0,62.5,250,0,").toUpperCase()
				+Hex.encodeHexString(bitmapData).toUpperCase()
				+str2Hex("\r\n").toUpperCase()
				+str2Hex("PRINT 1,1").toUpperCase();
		*/
		String tscFormat = "SIZE 4,2.5\r\n"+
							"SPEED 2.0\r\n"+
							"DENSITY 8\r\n"+
							"DIRECTION 1\r\n"+
							"SET TEAR ON\r\n"+
							"CODEPAGE UTF-8\r\n"+
							"CLS\r\n"+
							"BAR 100, 100, 300, 200\r\n"+
							"PRINT 1,1";
		System.out.println("tscFormat---->" + tscFormat);
		System.out.println("IP and Port ---> "+ IpAdress + "," + Port);
		
		Socket socket = null;
		DataOutputStream dos = null;
		try {
			socket = new Socket(IpAdress, Port);
			dos = new DataOutputStream(socket.getOutputStream());
			for (int i = 0 ; i < Count ; i++) {
				dos.writeBytes(tscFormat);
				++result;
			}
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (socket != null) {  try { socket.close(); } catch (IOException e) { e.printStackTrace(); }  }
			if (dos != null) {  try { dos.close(); } catch (IOException e) { e.printStackTrace(); }  }
		}
		
		return result;
		
	}
	
	
	

}

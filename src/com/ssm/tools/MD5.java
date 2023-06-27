package com.ssm.tools;

import sun.misc.BASE64Encoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/21 0021
 * @version: 1.0
 */
public class MD5 {
    public String encrypt(String oldStr)
    {
        String newStr;
        byte[] oldBytes=oldStr.getBytes();
        MessageDigest messageDigest;
        try{
            messageDigest= MessageDigest.getInstance("MD5");
            byte[] newBytes=messageDigest.digest(oldBytes);
            BASE64Encoder encoder=new BASE64Encoder();
            newStr=encoder.encode(newBytes);
            return newStr;
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        return null;
    }
}

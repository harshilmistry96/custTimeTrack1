<%@page import= "java.io.BufferedReader" %>
<%@page import= "java.io.IOException" %>
<%@page import= "java.io.InputStreamReader" %>
    <%
String IP=request.getParameter("IP");

String res="";

        Runtime run = Runtime.getRuntime();
        Process pr = run.exec("snmpget -v 2c -c public "+IP+" SNMPv2-MIB::sysUpTime.0");
        pr.waitFor();
        BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
        String line = "";
        //String res="";
            while ((line = buf.readLine()) != null)
            {
                res+=line+"\n";
            }
        int i=res.indexOf(")");
      //  System.out.println(i);

        res=res.substring(i+1).trim();

        //System.out.print(res);

    } catch (InterruptedException ex)
    {
        Logger.getLogger(myMain.class.getName()).log(Level.SEVERE, null, ex);
    }
    catch (IOException ex) {
            Logger.getLogger(myMain.class.getName()).log(Level.SEVERE, null, ex);
        }

%>
    
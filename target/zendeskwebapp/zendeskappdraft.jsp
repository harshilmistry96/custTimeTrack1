<%@page import= "org.zendesk.client.v2.Zendesk" %>
<%@page import= "org.zendesk.client.v2.model.CustomFieldValue" %>
<%@page import= "org.zendesk.client.v2.model.Ticket" %>
<%@page import= "java.util.*" %>
<%@page import= "org.apache.log4j.Logger" %>    
    <%
       final Logger logger = Logger.getLogger("zendeskapp");
       if (request.getParameter("id") == null) {
       logger.info("No id recieved!");
        out.println("No id recieved!");
       }
       else {
       logger.info("Id is recieved!" + request.getParameter("id")); 
        out.println("id " + request.getParameter("id")+"!");
        System.out.println("id " + request.getParameter("id"));
        String id1 = request.getParameter("id");
        Zendesk zd= new Zendesk.Builder("https://abcx.zendesk.com")
        .setUsername("hmistry16@gmail.com")
        .setPassword("9819938161").build();
       logger.info("Connection with zendesk established");
        Long id2 = Long.parseLong(id1);
        Ticket ticket = zd.getTicket(id2);
       logger.info("Ticket obtained by using the recieved id");
        List<CustomFieldValue> custpmFields = ticket.getCustomFields();
        //String timeTrackingAppValue = "0";
        CustomFieldValue cfv1 = null;
        int sec = 0;
        for (CustomFieldValue custFieVal : custpmFields)
            {
                if (custFieVal.getId() == 80067427l)
                {
                    //timeTrackingAppValue = custFieVal.getValue();
                    sec = Integer.parseInt(custFieVal.getValue());
                    logger.info("Time value retrieved for time tracking app:" + sec);
                }
                if (custFieVal.getId() == 80377887l)
                {
                    cfv1 = custFieVal;
                }
            }
        int c = sec/60;
        int min=0;
        int hour = 0;
        while(sec>=60)
        {
            sec=sec-60;
            min++;
        }
        if(min>60)
        {
            while(min>=60)
            {
                min=min-60;
                hour++;
            }
        }
        String s = "0";
        if(hour<10)
        {
                    s = s.concat(Integer.toString(hour));
                    if(min<10)
                    {
                        s = s.concat(":0" + Integer.toString(min));
				        if(sec<10){
							 s = s.concat(":0" + Integer.toString(sec));
				        }
                        else{
							 s = s.concat(":" + Integer.toString(sec));
						 }
					 }
					 else
					 {
						 s = s.concat(":" + Integer.toString(min));
						 if(sec<10)
						 {
							 s = s.concat(":0" + Integer.toString(sec));
						 }
						 else
						 {
							 s = s.concat(":" + Integer.toString(sec));
						 }
					 }
					 
				 }
				 else
				 {
					 s = Integer.toString(hour);
					 if(min<10)
					 {
						 s = s.concat(":0" + Integer.toString(min));
						 if(sec<10)
						 {
							 s = s.concat(":0" + Integer.toString(sec));
						 }
						 else
						 {
							 s = s.concat(":" + Integer.toString(sec));
						 }
					 }
					 else
					 {
						 s = s.concat(":" + Integer.toString(min));
						 if(sec<10)
						 {
							 s = s.concat(":0" + Integer.toString(sec));
						 }
						 else
						 {
							 s = s.concat(":" + Integer.toString(sec));
						 }
					 }
				 }    
               cfv1.setValue(s);
            logger.info("Time value appended in the custom field:'Time required to solve the ticket' " + cfv1.getValue());
            zd.updateTicket(ticket);
            logger.info("Ticket updated!");    
            System.out.println(cfv1.getId() + " " + cfv1.getValue());
            zd.close();    
    }
    %> 
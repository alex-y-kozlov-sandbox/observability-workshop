# Teams - Lab Summary

* Create a team and add members to team
* Discover how you can restrict usage for teams by creating separate access tokens and set limits.

---

## 1. Introduction to Teams

To make sure that users  see the dashboards and alerts that are relevant to them when using SignalFX, most organizations will use SignalFx's Teams mechanism to assign a user to one or more Teams. Usually this matches work related roles, for example, members of a Dev-Ops or Product Management group would be assigned to the corresponding Teams in SignalFx.

When a user logs into SignalFx, they can choose which team dashboard will be their home page and they will typically select the page for their primary role.

In the example below, the user is a member of the Development, Operations and Product Management Teams, and is currently viewing the Dashboard for the Operations Team.  This Dashboard has specific Dashboard Groups for Nginx, Infra and K8S assigned but any Dashboard Group can be linked to a Teams Dashboard.

They can use the menu along the top left to quickly navigate between their allocated teams, or they can use the All TEAMS dropdown on the right to select specific Team Dashboards, as well as quickly accessing All Dashboards using the adjacent link.

![Teams](../images/module5/m5-team-homepage.png){: .zoom}

Alerts can be linked to specific Teams so the Team can monitor only the Alerts they are interested in, and in the above example they currently have 1 active Critical Alert.

The Description for the Team Dashboard can be customized and can include links to team specific resources.

---

## 2. Creating a new Team

To work with  to SignalFx's Team UI click on the **Settings** icon on the top right of the SignalFx UI, ![Settings Icon](../images/module5/M5-l1-1.png)(it may also look like this ![gray user icon](../images/module5/M5-l1-2.png)) and select the **Organizations Settings → Teams** tab, or select the **Teams** tab from the left pane.

![location of settings](../images/module5/M1-l7-7.jpg)

When the **Team** UI is selected you will be presented with the list of current Teams.
  
---

To add a new **Team** click on the green ![Create team](../images/module5/M1-l7-15.jpg) button. This will present you with the **Create New Team** Dialog.

![Add Team](../images/module5/M1-l7-16.jpg){: .shadow}

Create your own team by naming it [YOUR-INITIALS]-Team and add yourself by searching for your name and selecting the **Add** link next to your name. This should result in a dialog similar to the one below:

You can remove selected users by pressing  **remove** or the small **x** behind a name.
Make sure you have your group created with your initials and with yourself added as a member, then press done.

![Add Team complete](../images/module5/M1-l7-17.jpg)

This will bring you back to the **Teams** list that will now show your Team and the one's created by others.

!!! note
    The Teams(s) you are a member of have a grey **Member** icon in front of it.

If no members are assigned to your Team, you should see a blue **Add members** link instead of the member count, clicking on that link will get you to the **Edit Team** dialog where you can add yourself.

This is the same dialog you get when pressing the 3 dots **...** at the end of the line with your Team and selecting **Edit Team**

The **...** menu gives you the option to Edit, Join, Leave or Delete a Team (leave and join will depend on if you are currently a member).

---

## 3. Adding Notification Rules to a Team

You can set up specific Notification rules per team, click on the **NOTIFICATION POLICY** Button, this will open the notification edit menu.

![Base notification menu](../images/module5/M1-l7-18.jpg)

By default the system offers you the ability to set up a general notification rule for your team.
Note the Email all team members option. This means all members of this team will receive an email with the Alert information, regardless of the alert type.

You can add other recipients, by clicking ![add recipient](../images/module5/M1-l7-19.jpg)

You can add multiple email addresses to inform none SignalFx users such as
_alerts@your-company.com_. Using this setting will ensure these external users will be notified of alerts whenever the recipients setting within a Detector has this Team selected as one of the options.

However if you click on the link **Configure separate notification tiers for different severity alerts** you can configure every alert level differently.

![Multiple Notifications](../images/module5/M1-l7-10.jpg)

Different alert rules for the different alert levels can be configured, as shown in the above image.

Critical and Major are using Splunk's VictorOps offering. For the Minor alerts we send it to the Teams Slack channel and for Warning and Info we send an email.

Below you see some of the Notification options you can install in your SignalFx Organization:

![Notifications options](../images/module5/M1-l7-20.jpg)

Take a moment to create some notification rules for you Team.

---

## 4. Controlling a Team's usage

If you wish to control the consumption of Hosts, Containers, Custom Metrics and High Resolution Metrics, you can create multiple Access Tokens and allocate them to different parts of your organization.

Assuming you are still within the Organization Overview section, simply select the **Access Tokens** tab from the left pane.

![Select Token](../images/module5/M1-l7-13.jpg)

However to get to this section from anywhere click on the settings ![gray user icon](../images/module5/M5-l1-2.png) icon at the top right top of the page and select **Organizations Settings → Access tokens**

The **Access Tokens** Interface provides an overview of your Allotments in the form of a list of Access Tokens that have been generated. Every Organization will have a **Default** token generated when they are first setup, but there will typically be multiple Tokens configured.

Each Token is unique and can be assigned limits for the amount of Hosts, Containers, Custom Metrics and High Resolution Metrics it can consume.

The **Usage Status** Column quickly shows if a token is above or below its assigned limits.

![New token](../images/module5/M1-l7-21.jpg)

---

Let create a new token by clicking on  the ![new token button](../images/module5/M1-l7-22.jpg) button. This will provide you with the **Name Your Access Token** dialog.

Enter the new name of the new Token by using your Initials e.g. PH-Token

![Name Your token](../images/module5/M1-l7-23.jpg){: .shadow}

After you press Ok,  you will be taken back to the **Access Token** UI, here your new token should be present, among the ones created by others.

![full tokenlist](../images/module5/M1-l7-24.jpg)

If you have made an error in your naming, want to disable/enable a token or set a Token limit, click on the 3 **...** menu button behind a token limit to open the manage token menu.

![Show Menu](../images/module5/M1-l7-25.jpg)

If you made a typo you can use the Rename Token option to correct the name of your token.

---

If you need to make sure a token cannot be used to send Metrics in you can Disable a token.
Click on the Disable button to Disable the token, this means the token cannot be used for sending in data to SignalFX.

The line with Your Token should become greyed out to indicate that is has been Disabled as you can see in the screenshot below.

![Token disabled](../images/module5/M1-l7-26.jpg)

Go ahead and click on the 3 **...** menu button to Disable and Enable your token.

---

Now Lets start limiting usage by clicking on Manage Token Limit in the 3 **...** menu.

This will show the Manage Token Limit Dialog:

![Set Limits on token](../images/module5/M1-l7-12.jpg){: .shadow}

In this Dialog you can set the limits per category.

Please go ahead and specify the limits as shown above for each usage metric.
For our lab use your own email address, and double check that you have the correct numbers in your dialog box as shown above.

Token limits are used to trigger an alert that notify one or more recipients when the usage has been above 90% of the limit for 5 minutes. To specify the recipients, click Add Recipient, then select the recipient or notification method you want to use. (Specifying recipients is optional but highly recommended.) The severity for token alerts is always Critical.

Click on **Update** to save your Access Tokens limits and The Alert Settings.

!!! Note
    When a token is at or above its limit in a usage category, new metrics for that usage category will not be stored and processed by SignalFx. This will make sure you there  will be no unexpected cost due to a team sending in data without restriction.

!!! Note
    If you wish to get alerts before you hit 90%, you can create additional detectors using whatever values you want. These detectors could target the Teams consuming the specific Access Tokens so they can take action before the admins need to get involved.

In your company you would distribute these new Access Tokens to various teams, controlling how much information/data they can send to SignalFx. This will allow you to fine tune the way you consume your SignalFx allotment and stop expensive surprises from happening.

**Congratulations!** You have now have completed the Service Bureau module.
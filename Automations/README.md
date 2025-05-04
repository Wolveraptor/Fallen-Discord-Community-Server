<!-- omit from toc -->
# Fallen | Automations
* Fallen Discord community server automations.

<!-- omit from toc -->
## Fallen | About Automations
* This README.md serves as documentation and changelog for the Fallen Discord community server automations.

![alttext](/Images/Fallen%20-%20Server%20Icon%20-%20545x390.png)

<!-- omit from toc -->
### Fallen | Table of Contents
* [Automations - README.md](/Automations/README.md)
* [Bad Words - README.md](/Bad%20Words/README.md)
* [Categories and Channels - README.md](/Categories%20and%20Channels/README.md)
* [Community Roles - README.md](/Community%20Roles/README.md)
* [Community Rules - README.md](/Community%20Rules/README.md)
* [Embedded Messages - README.md](/Embedded%20Messages/README.md)
* [Events - README.md](/Events/README.md)
* [Images](/Images/)
* [Reaction Roles - README.md](/Reaction%20Roles/README.md)
* [Ticketing - README.md](/Ticketing/README.md)
* [Welcome and Goodbye Message - README.md](/Welcome%20and%20Goodbye%20Message/README.md)
* [Welcome Channel - README.md](/Welcome%20Channel/README.md)

<!-- omit from toc -->
### Fallen | Automations | Table of Contents
* [Fallen | Automations | raid-loot-roll "/roll" and "/roll limit:100" Correction - 05/04/25 – 3:11 PM EST](#fallen--automations--raid-loot-roll-roll-and-roll-limit100-correction---050425--311-pm-est)

#### Fallen | Automations | raid-loot-roll "/roll" and "/roll limit:100" Correction - 05/04/25 – 3:11 PM EST
* When Someone:
    * Sends a message
* Conditions:
    * If:
        * It happened in one of these channels or categories
            * Channel: `🎲・raid-loot-roll`
    * And:
        * The user does not have one of these roles
            * Roles: `King` and `King Council`
    * And:
        * The message does not contain one of these words or sentences
            * Word or sentence: `/roll limit:100` or `/roll`
* Do This:
    * Delete Message
    * Send a message
        * Channel: `🎲・raid-loot-roll`
        * Message:
            ```
            Whoops {user.mention}, you are not permitted to send messages in this channel that are not `/roll limit:100` and as a result your message has been deleted.

            Please limit your messages to only `/roll limit:100` to roll for loot.

            Note: Only the <@&1184163679034429460> and <@&1184165070016610404> roles can post messages in this channel that are not `/roll limit:100`.
            ```
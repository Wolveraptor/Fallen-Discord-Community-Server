<!-- omit from toc -->
# Fallen | Automations
* Fallen Discord community server automations.

<!-- omit from toc -->
## Fallen | About Automations
* This README.md serves as documentation and changelog for the Fallen Discord community server automations.

![alttext](/Images/Server%20Icons/Fallen%20-%20Server%20Icons%20-%20949x969.png)

<!-- omit from toc -->
### Fallen | Table of Contents
* [Automations - README.md](/Automations/README.md)
* [Bad Words - README.md](/Bad%20Words/README.md)
* [Categories and Channels - README.md](/Categories%20and%20Channels/README.md)
* [Community Roles - README.md](/Community%20Roles/README.md)
* [Community Rules - README.md](/Community%20Rules/README.md)
* [Custom Commands - README.md](/Custom%20Commands/README.md)
* [Embedded Messages - README.md](/Embedded%20Messages/README.md)
* [Events - README.md](/Events/README.md)
* [Images](/Images/)
* [Reaction Roles - README.md](/Reaction%20Roles/README.md)
* [Ticketing - README.md](/Ticketing/README.md)
* [Welcome and Goodbye Message - README.md](/Welcome%20and%20Goodbye%20Message/README.md)
* [Welcome Channel - README.md](/Welcome%20Channel/README.md)

<!-- omit from toc -->
### Fallen | Automations | Table of Contents
* [Fallen | Automations | DISABLED - raid-loot-roll "/roll" and "/roll limit:100" Correction - 05/04/25 – 3:11 PM EST](#fallen--automations--disabled---raid-loot-roll-roll-and-roll-limit100-correction---050425--311-pm-est)
* [Fallen | Automations | raid-loot-roll -  Squire Sends Message - Delete and Inform - 05/14/25 – 10:25 PM EST](#fallen--automations--raid-loot-roll----squire-sends-message---delete-and-inform---051425--1025-pm-est)
* [Fallen | Automations | raid-loot-roll -  Squire Sends Image and Message - Delete and Inform - 05/14/25 – 10:25 PM EST](#fallen--automations--raid-loot-roll----squire-sends-image-and-message---delete-and-inform---051425--1025-pm-est)
* [Fallen | Automations | raid-loot-roll -  Squire Sends Image - Delete and Inform - 05/14/25 – 10:25 PM EST](#fallen--automations--raid-loot-roll----squire-sends-image---delete-and-inform---051425--1025-pm-est)

#### Fallen | Automations | DISABLED - raid-loot-roll "/roll" and "/roll limit:100" Correction - 05/04/25 – 3:11 PM EST
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

#### Fallen | Automations | raid-loot-roll -  Squire Sends Message - Delete and Inform - 05/14/25 – 10:25 PM EST
* When Someone:
    * Sends a message
* Conditions:
    * If:
        * It happened in one of these channels or categories
            * Channel: `🎲・raid-loot-roll`
    * And:
        * The message does not contain one of these words or sentences
            * Word or sentence: `/roll limit:100` or `/roll`
    * And:
        * The user does not have one of these roles
            * Roles: `King`, `King Council`, `Guild Elder`, `Paragon`, `Champion`, or `Knight`.
* Do This:
    * Delete Message
    * Send a message
        * Channel: `🎲・raid-loot-roll`
        * Message:
            ```
            Whoops {user.mention}, you are not permitted to send messages in this channel that are not `/roll limit:100` and as a result your message has been deleted.

            Please limit your messages to only `/roll limit:100` to roll for loot.

            Note: Only the <@&1184163679034429460>, <@&1184165070016610404>, <@&1297404589989171271>, <@&1372013033475539034>,  <@&1184166231205490699>, and <@&1184166555815256095>, roles can messages in this channel that are not `/roll limit:100`.
            ```

#### Fallen | Automations | raid-loot-roll -  Squire Sends Image and Message - Delete and Inform - 05/14/25 – 10:25 PM EST
* When Someone:
    * Sends a message
* Conditions:
    * If:
        * It happened in one of these channels or categories
            * Channel: `🎲・raid-loot-roll`
    * And:
        * The message has an image attachment.
    * And:
        * The message does not contain one of these words or sentences
            * Word or sentence: `/roll limit:100` or `/roll`
    * And:
        * The user does not have one of these roles
            * Roles: `King`, `King Council`, `Guild Elder`, `Paragon`, `Champion`, or `Knight`.
* Do This:
    * Delete Message
    * Send a message
        * Channel: `🎲・raid-loot-roll`
        * Message:
            ```
            Whoops {user.mention}, you are not permitted to post images in this channel or messages in this channel that are not `/roll limit:100` and as a result your message has been deleted.

            Please limit your messages to only `/roll limit:100` to roll for loot.

            Note: Only the <@&1184163679034429460>, <@&1184165070016610404>, <@&1297404589989171271>, <@&1372013033475539034>,  <@&1184166231205490699>, and <@&1184166555815256095>, roles can post images in this channel.
            ```

#### Fallen | Automations | raid-loot-roll -  Squire Sends Image - Delete and Inform - 05/14/25 – 10:25 PM EST
* When Someone:
    * Sends a message
* Conditions:
    * If:
        * It happened in one of these channels or categories
            * Channel: `🎲・raid-loot-roll`
    * And:
        * The message has an image attachment.
    * And:
        * The user does not have one of these roles
            * Roles: `King`, `King Council`, `Guild Elder`, `Paragon`, `Champion`, or `Knight`.
* Do This:
    * Delete Message
    * Send a message
        * Channel: `🎲・raid-loot-roll`
        * Message:
            ```
            Whoops {user.mention}, you are not permitted to post images in this channel.

            Please limit your messages to only `/roll limit:100` to roll for loot.

            Note: Only the <@&1184163679034429460>, <@&1184165070016610404>, <@&1372013033475539034>, <@&1297404589989171271>,  <@&1184166231205490699>, and <@&1184166555815256095>, roles can post images in this channel.
            ```
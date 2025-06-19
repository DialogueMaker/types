--!strict
-- This is a giant types file that contains all the types used in Dialogue Maker classes.
-- I'm not the biggest fan of this approach, but this is necessary to avoid circular dependencies.
-- 
-- Programmer: Christian Toney
-- © 2025 Dialogue Maker Group

local React = require(script.Parent.roblox_packages.react);
local ReactRoblox = require(script.Parent.roblox_packages["react-roblox"]);

-- Client
export type ThemeComponent = React.ComponentType<ThemeProperties> | React.React_MemoComponent<ThemeProperties, any>;

export type ConstructorClientSettings = {

  theme: {

    -- This is the default theme that will be used when talking with NPCs
    component: ThemeComponent;

  };
  keybinds: {

    --[[
      Keyboard keybind to start a conversation with a character.
    ]]
    interactKey: Enum.KeyCode?;

    --[[
      Gamepad keybind to start a conversation with a character.
    ]]
    interactKeyGamepad: Enum.KeyCode?;

  }?;
  typewriter: OptionalClientTypewriterSettings?;

}

export type ClientThemeSettings = {

  --[[
    This is the default theme that will be used when talking with NPCs.
    This may be overriden by the conversation or dialogue settings.
  ]]
  component: ThemeComponent;

}

export type ClientKeybindSettings = {

  --[[
    Keyboard keybind to start a conversation with a character.
  ]]
  interactKey: Enum.KeyCode?;

  --[[
    Gamepad keybind to start a conversation with a character.
  ]]
  interactKeyGamepad: Enum.KeyCode?;

}

export type ClientTypewriterSettings = {

  --[[
    The delay between each letter being typed.
  ]] 
  characterDelaySeconds: number;

  --[[
    If true, the player can skip the typing delay by pressing a keybind or clicking the theme.
  ]]
  canPlayerSkipDelay: boolean;

  --[[
    This is useful for themes that show the response while typing.
  ]]
  shouldShowResponseWhileTyping: boolean;

}

export type ClientSettings = {
  theme: ClientThemeSettings;
  keybinds: ClientKeybindSettings;
  typewriter: ClientTypewriterSettings;
};

export type OptionalClientThemeSettings = {

  -- This is the default theme that will be used when talking with NPCs
  component: ThemeComponent?;

}

export type OptionalClientKeybindSettings = {

  --[[
    Keyboard keybind to start a conversation with a character.
  ]]
  interactKey: Enum.KeyCode?;

  --[[
    Gamepad keybind to start a conversation with a character.
  ]]
  interactKeyGamepad: Enum.KeyCode?;

}

export type OptionalClientTypewriterSettings = {

  --[[
    The delay between each letter being typed.
  ]] 
  characterDelaySeconds: number?;

  --[[
    If true, the player can skip the typing delay by pressing a keybind or clicking the theme.
  ]]
  canPlayerSkipDelay: boolean?;

  --[[
    This is useful for themes that show the response while typing.
  ]]
  shouldShowResponseWhileTyping: boolean?;

}

export type OptionalClientSettings = {
  theme: OptionalClientThemeSettings?;
  keybinds: OptionalClientKeybindSettings?;
  typewriter: OptionalClientTypewriterSettings?;
};

export type OptionalClientConstructorProperties = {
  settings: ConstructorClientSettings?;
  dialogue: Dialogue?;
  conversation: Conversation?;
  dialogueGUI: ScreenGui?;
  reactRoot: ReactRoblox.RootType?;
  continueDialogueBindableFunction: BindableFunction?;
}

export type ClientProperties = {

  --[[
    The settings for the client.
  ]]
  settings: ClientSettings;

  dialogue: Dialogue;

  conversation: Conversation;

  reactRoot: ReactRoblox.RootType;

  dialogueGUI: ScreenGui;

  continueDialogueBindableFunction: BindableFunction;

}

export type ClientMethods = {

  clone: (self: Client, properties: OptionalClientConstructorProperties?) -> Client;

  --[[

  ]]
  continueDialogue: (self: Client) -> ();

  --[[
    Destroys the GUI elements created by the client.
  ]]
  cleanup: (self: Client) -> ();

}

export type Client = ClientProperties & ClientMethods;

-- Conversation
export type TypewriterConversationSettings = {

  -- The delay between each letter being typed. 
  characterDelaySeconds: number?; 

  -- If true, the player can skip the typing delay by pressing a keybind or clicking the theme. 
  canPlayerSkipDelay: boolean?;

  --[[
    This is useful for themes that show the response while typing.
  ]]
  shouldShowResponseWhileTyping: boolean?;

}

export type ConversationSettings = {
  theme: ThemeConversationSettings;
  speaker: SpeakerConversationSettings;
  typewriter: TypewriterConversationSettings;
}

export type SpeakerConversationSettings = {
  --[[
    The character's name. Themes may show this name to the player during the conversation.
  ]]
  name: string?;
}

export type ThemeConversationSettings = {
  --[[
    Change this to a theme you've added to the Themes folder in order to override default theme settings.
  ]]
  component: ThemeComponent?;
}

export type OptionalThemeConversationSettings = {

  --[[
    The theme component that will be used to render the conversation.
    This is prioritized over the client theme, but may be overridden by dialogue settings.
  ]]
  component: ThemeComponent?;

}

export type OptionalConversationSettings = {
  speaker: {
    --[[
      The character's name. Themes may show this name to the player during the conversation.
    ]]
    name: string?;
  }?;
  theme: OptionalThemeConversationSettings?;
  typewriter: OptionalTypewriterConversationSettings?;
}

export type OptionalTypewriterConversationSettings = {

  -- The delay between each letter being typed. 
  characterDelaySeconds: number?; 

  -- If true, the player can skip the typing delay by pressing a keybind or clicking the theme. 
  canPlayerSkipDelay: boolean?;

  --[[
    This is useful for themes that show the response while typing.
  ]]
  shouldShowResponseWhileTyping: boolean?;

};

export type ConversationProperties = {

  type: "Conversation";

  --[[
    The conversation's children, which are dialogues that are linked to this conversation.
  ]]
  children: {Dialogue};

  --[[
    The conversation's speaker settings. 
    These settings are over the conversation settings.
  ]]
  settings: ConversationSettings;

}

export type ConversationMethods = {

  --[[
    Finds the next dialogue that should be shown to the player. This returns nil if no verified dialogue is found.
  ]]
  findNextVerifiedDialogue: (self: Conversation) -> Dialogue?;

  --[[
    Attempts to get the next verified dialogue in the conversation.
    Errors if no verified dialogue is found.
  ]]
  getNextVerifiedDialogue: (self: Conversation) -> Dialogue;

};

export type Conversation = ConversationProperties & ConversationMethods;

-- Dialogue
export type Dialogue = DialogueProperties & DialogueMethods;

export type Page = {string | Effect};

export type GetContentFunction = (self: Dialogue) -> Page;

export type DialogueGetChildrenFunction = (self: Dialogue) -> {Dialogue};

export type DialogueConstructorContent = string | Effect | Page | GetContentFunction;

export type DialogueConstructorChildren = {Dialogue} | DialogueGetChildrenFunction;

export type DialogueProperties = {

  --[[
    The dialogue's parent.
  ]]
  parent: (Dialogue | Conversation)?;

  --[[
    The dialogue's settings.
    These settings are over the client and conversation settings.
  ]]
  settings: DialogueSettings;

  --[[
    The dialogue type.

    * Messages are shown to the player and may contain text or effects.

    * Responses are shown to the player and allow them to choose a response.

    * Redirects are used to redirect the player to another message without showing any content.
  ]]
  type: "Message" | "Response" | "Redirect";

}

export type DialogueConstructorProperties = {
  parent: (Dialogue | Conversation)?;
  runInitializationAction: RunInitializationActionFunction?;
  runCompletionAction: RunCompletionActionFunction?;
  runCleanupAction: RunCleanupActionFunction?;
  verifyCondition: VerifyConditionFunction?;
  settings: OptionalDialogueSettings?;
}

export type DialogueType = "Message" | "Response" | "Redirect";

export type DialogueConstructorPropertiesWithType = DialogueConstructorProperties & {
  type: DialogueType;
}

export type OptionalDialogueConstructorProperties = {
  parent: (Dialogue | Conversation)?;
  content: (string | Effect | Page)?;
  getContent: GetContentFunction?;
  children: {Dialogue}?;
  getChildren: ((self: Dialogue) -> {Dialogue})?;
  runInitializationAction: RunInitializationActionFunction?;
  runCleanupAction: RunCleanupActionFunction?;
  runCompletionAction: RunCompletionActionFunction?;
  verifyCondition: VerifyConditionFunction?;
  settings: OptionalDialogueSettings?;
  type: DialogueType?;
}

export type RunInitializationActionFunction = (self: Dialogue, client: Client) -> ();
export type RunCompletionActionFunction = (self: Dialogue, client: Client) -> ();
export type RunCleanupActionFunction = (self: Dialogue, client: Client, requestedDialogue: Dialogue?) -> ();
export type VerifyConditionFunction = (self: Dialogue) -> boolean;
export type GetChildrenFunction = (self: Dialogue) -> {Dialogue};
export type DialogueFindNextVerifiedDialogueFunction = (self: Dialogue) -> Dialogue?
export type DialogueGetNextVerifiedDialogueFunction = (self: Dialogue) -> Dialogue;

export type DialogueMethods = {

  --[[
    Clones the dialogue and returns a new dialogue.
    This is useful for creating a new dialogue with similar settings.
  ]]
  clone: (self: Dialogue, newProperties: OptionalDialogueConstructorProperties?) -> Dialogue;

  --[[
    Gets an array of text or effects that represent the dialogue content.

    Keep in mind that some themes may be blank or not show until this function returns.

    This function is not intended for redirects, as redirects will not show any content.
  ]]
  getContent: GetContentFunction;

  --[[
    Checks whether the dialogue should be shown based on a user-defined function.
  ]]
  verifyCondition: VerifyConditionFunction;

  --[[
    Finds the next dialogue that should be shown to the player. This returns nil if no verified dialogue is found.
  ]]
  findNextVerifiedDialogue: DialogueFindNextVerifiedDialogueFunction;

  --[[
    Attempts to get the next verified child in the dialogue.
    Errors if no verified dialogue is found.
  ]]
  getNextVerifiedDialogue: DialogueGetNextVerifiedDialogueFunction;

  --[[
    Runs a user-defined function that is intended to run before a message is shown, or before a redirect.
  ]]
  runInitializationAction: RunInitializationActionFunction;

  runDefaultCleanupAction: RunCleanupActionFunction;

  --[[
    Runs a user-defined function that is intended to run before the next message is shown.

    Some themes may request a specific dialogue to be shown. For example, when a player chooses a response.
    Any applicable requested dialogue is passed as an argument to this function.

    This function is not intended for redirects.
  ]]
  runCleanupAction: RunCleanupActionFunction;

  --[[
    Runs a user-defined function that is intended to run after a message is fully rendered.

    This function is not intended for redirects.
  ]]
  runCompletionAction: RunCompletionActionFunction;

  --[[
    Gets the dialogue's children, which are dialogues that are linked to this dialogue.
  ]]
  getChildren: GetChildrenFunction;

  --[[
    Gets the parent of the dialogue.

    Errors if there is no parent.
  ]]
  getParent: (self: Dialogue) -> (Dialogue | Conversation);

  --[[
    Gets the conversation that this dialogue is a part of.
    This is a shortcut for looping through getParent and checking if the parent is a Conversation.
    
    Errors if there is no conversation ancestor.
  ]]
  getConversation: (self: Dialogue) -> Conversation;

}

export type ThemeDialogueSettings = {

  --[[
    The theme component that will be used to render the dialogue.
    This is prioritized over the conversation and client themes.
  ]]
  component: ThemeComponent?;

}

export type OptionalThemeDialogueSettings = {

  component: ThemeComponent?;

}

export type DialogueSpeakerSettings = {

  --[[
    The speaker's name. Themes may show this name to the player during the conversation.
    This is prioritized over the conversation speaker name.
  ]]
  name: string?;

}

export type OptionalDialogueSpeakerSettings = {

  --[[
    The speaker's name. Themes may show this name to the player during the conversation.
    This is prioritized over the conversation speaker name.
  ]]
  name: string?;

}

export type DialogueSettings = {
  theme: ThemeDialogueSettings;
  typewriter: TypewriterDialogueSettings;
  speaker: DialogueSpeakerSettings;
}

export type OptionalDialogueSettings = {
  speaker: OptionalDialogueSpeakerSettings?;
  theme: OptionalThemeDialogueSettings?;
  typewriter: OptionalTypewriterDialogueSettings?;
}

export type OptionalTypewriterDialogueSettings = {
  -- The delay between each letter being typed. 
  characterDelaySeconds: number?;
  -- If true, the player can skip the typing delay by pressing a keybind or clicking the theme. 
  canPlayerSkipDelay: boolean?;
  shouldShowResponseWhileTyping: boolean?;
}

export type TypewriterDialogueSettings = {

  --[[
    The delay between each letter being typed.
  ]] 
  characterDelaySeconds: number?;

  --[[
    If true, the player can skip the typing delay by pressing a keybind or clicking the theme.
  ]]
  canPlayerSkipDelay: boolean?;

  --[[
    This is useful for themes that show the response while typing.
  ]]
  shouldShowResponseWhileTyping: boolean?;

}

-- Effect
export type Bounds = {
  width: number;
  height: number;
};

export type ExecutionProperties = {
  skipPageEvent: BindableEvent?;
  shouldSkip: boolean;
  continuePage: ContinuePageFunction;
  textComponent: React.ComponentType<any> | React.React_MemoComponent<any, any>;
  textComponentProperties: {
    [any]: any;
  };
  key: string;
}

export type ContinuePageFunction = () -> ();

export type RunEffectFunctionReturnValue = React.ReactElement<any, any>?;

export type RunEffectFunction = (self: Effect, executionProperties: ExecutionProperties) -> RunEffectFunctionReturnValue;

export type Effect = {
  
  type: "Effect";
  
  run: RunEffectFunction;
  
  name: string;

}

-- Theme
export type ThemeProperties = {
  client: Client;
}

return {};
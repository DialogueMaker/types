--!strict
-- This is a giant types file that contains all the types used in Dialogue Maker classes.
-- I'm not the biggest fan of this approach, but this is necessary to avoid circular dependencies.
-- 
-- Programmer: Christian Toney
-- © 2025 Dialogue Maker Group

local React = require(script.Parent.roblox_packages.react);

-- Client
export type ThemeComponent = React.ComponentType<ThemeProperties>;

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

  soundTemplate: Sound?; 

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

  soundTemplate: Sound?;

}

export type OptionalClientSettings = {
  theme: OptionalClientThemeSettings?;
  keybinds: OptionalClientKeybindSettings?;
  typewriter: OptionalClientTypewriterSettings?;
};

export type ClientProperties = {

  --[[
    The settings for the client.
  ]]
  settings: ClientSettings;

}

export type ClientMethods = {

  --[[
    Gets the current dialogue that is being shown to the player.
  ]]
  getDialogue: (self: Client) -> Dialogue?;

  --[[
    Sets the current dialogue that is being shown to the player.
    This will also render or re-render the theme.

    You must set the conversation before setting the dialogue, as some conversations override client settings.
  ]]
  setDialogue: (self: Client, newDialogue: Dialogue?) -> Client;

  --[[

  ]]
  requestPageSkip: (self: Client) -> ();

}

export type Client = ClientProperties & ClientMethods;

-- Conversation
export type TypewriterConversationSettings = {

  --[[
    The delay between each letter being typed.
    This overrides the client sound template, but this may be overridden by the dialogue settings.
  ]]
  soundTemplate: Sound?; 

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

export type OptionalThemeSettings = {

  --[[
      Change this to a React element 
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
  theme: {
    --[[
      Change this to a theme you've added to the Themes folder in order to override default theme settings.
    ]]
    component: React.ReactElement?;
  }?;
  typewriter: OptionalTypewriterConversationSettings?;
}

export type OptionalTypewriterConversationSettings = {

  -- The delay between each letter being typed. 
  characterDelaySeconds: number?; 

  -- If true, the player can skip the typing delay by pressing a keybind or clicking the theme. 
  canPlayerSkipDelay: boolean?; 

  --[[
    The delay between each letter being typed.
    This overrides the client sound template, but this may be overridden by the dialogue settings.
  ]]
  soundTemplate: Sound?; 

};

export type ConversationProperties = {

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
};

export type Conversation = ConversationProperties & ConversationMethods;

-- Dialogue
export type Dialogue = DialogueProperties & DialogueMethods;

export type Page = {string | Effect};

export type GetContentFunction = (self: Dialogue) -> Page;

export type DialogueProperties = {

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

export type RunInitializationActionFunction = (self: Dialogue, client: Client) -> ();
export type RunCompletionActionFunction = (self: Dialogue, client: Client, requestedDialogue: Dialogue?) -> ();
export type VerifyConditionFunction = (self: Dialogue) -> boolean;
export type GetChildrenFunction = (self: Dialogue) -> {Dialogue};
export type DialogueFindNextVerifiedDialogueFunction = (self: Dialogue) -> Dialogue?

export type DialogueMethods = {

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
    Runs a user-defined function that is intended to run before a message is shown, or before a redirect.
  ]]
  runInitializationAction: RunInitializationActionFunction;

  --[[
    Runs a user-defined function that is intended to run after a message is shown.

    Some themes may request a specific dialogue to be shown. For example, when a player chooses a response.
    Any applicable requested dialogue is passed as an argument to this function.

    This function is not intended for redirects.
  ]]
  runCompletionAction: RunCompletionActionFunction;

  --[[
    Gets the dialogue's children, which are dialogues that are linked to this dialogue.
  ]]
  getChildren: GetChildrenFunction;

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
  theme: OptionalThemeDialogueSettings?;
  typewriter: OptionalTypewriterDialogueSettings?;
  speaker: OptionalDialogueSpeakerSettings?;
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

-- DialogueContentFitter
export type DialogueContentFitter = DialogueContentFitterProperties & DialogueContentFitterMethods;

export type DialogueContentFitterMethods = {
  getPages: (self: DialogueContentFitter, rawPage: Page) -> ({Page});
}

export type DialogueContentFitterProperties = {
  textLabel: TextLabel;
  contentContainer: GuiObject;
}

export type RichTextTag = {
  attributes: string?;
  endOffset: number?;
  name: string;
  startOffset: number;
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
  textComponent: (...any) -> React.ReactElement<any, any>;
  textComponentProperties: any;
  key: string;
}

export type ContinuePageFunction = () -> ();

export type RunEffectFunctionReturnValue = React.ReactElement<any, any>?;

export type RunEffectFunction = (self: Effect, executionProperties: ExecutionProperties) -> RunEffectFunctionReturnValue;

export type FitFunction = (self: Effect, contentContainer: GuiObject, textLabel: TextLabel, pages: {Page}) -> (GuiObject, {Page});

export type Effect = {
  
  type: "Effect";
  
  run: RunEffectFunction;

  fit: FitFunction;
  
  name: string;

}

-- Theme
export type ThemeProperties = {
  client: Client;
}

export type TextComponentProperties = {
  text: string;
  skipPageSignal: RBXScriptSignal?;
  letterDelay: number;
  layoutOrder: number;
  textSize: number;
  onComplete: () -> ();
  lineHeight: number;
}

return {};
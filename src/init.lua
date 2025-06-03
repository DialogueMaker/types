--!strict
-- This is a giant types file that contains all the types used in Dialogue Maker classes.
-- I'm not the biggest fan of this approach, but this is necessary to avoid circular dependencies.
-- 
-- Programmer: Christian Toney
-- © 2025 Dialogue Maker Group

local React = require(script.Parent.roblox_packages.react);

-- Client
export type ConstructorClientSettings = {

  general: {

    -- This is the default theme that will be used when talking with NPCs
    theme: ModuleScript;

    shouldEndConversationOnCharacterRemoval: boolean?;

  };
  responses: {

    -- Replace this with an audio ID that'll play every time a player selects a response. Replace with 0 to not play any sound.
    clickSound: number?;

  }?;
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

export type ClientSettings = {

  general: {

    -- This is the default theme that will be used when talking with NPCs
    theme: ModuleScript;

    shouldEndConversationOnCharacterRemoval: boolean;

  };
  responses: {

    -- Replace this with an audio ID that'll play every time a player selects a response. Replace with 0 to not play any sound.
    clickSound: number?;

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

  };
};

export type OptionalClientSettings = {

  general: {

    -- This is the default theme that will be used when talking with NPCs
    theme: ModuleScript?;

    shouldEndConversationOnCharacterRemoval: boolean?;

  }?;
  responses: {

    -- Replace this with an audio ID that'll play every time a player selects a response. Replace with 0 to not play any sound.
    clickSound: number?;

  }?;
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
};

export type ClientMethods = {
  freezePlayer: (self: Client) -> ();
  unfreezePlayer: (self: Client) -> ();
  interact: (self: Client, conversation: Conversation) -> ();
  getSettings: (self: Client) -> ClientSettings;
  setSettings: (self: Client, newSettings: ClientSettings) -> ();
  getConversation: (self: Client) -> Conversation?;
  setConversation: (self: Client, newConversation: Conversation?) -> ();
}

export type ClientEvents = {
  SettingsChanged: RBXScriptSignal<ClientSettings>;
  ConversationChanged: RBXScriptSignal;
}

export type Client = ClientMethods & ClientEvents;

-- Conversation
export type ClickDetectorConversationSettings = {
  -- If true, this automatically creates a ClickDetector inside of the NPC's model. 
  shouldAutoCreate: boolean; 
  -- If true, the ClickDetector's parent will be nil until the dialogue is over. This hides the cursor from the player. 
  shouldDisappearDuringConversation: boolean; 
  -- Replace this with the location of the ClickDetector. (Ex. workspace.Model.ClickDetector) This setting will be ignored if AutomaticallyCreateClickDetector is true. 
  instance: ClickDetector?;
  adornee: Instance?;
}

export type DistanceConversationSettings = {
  -- Maximum magnitude between the NPC's HumanoidRootPart and the player's PrimaryPart before the conversation ends. Requires EndConversationIfOutOfDistance to be true.
  maxConversationDistance: number?;
  relativePart: BasePart?;
}

export type ConversationSettings = {
  clickDetector: ClickDetectorConversationSettings;
  distance: DistanceConversationSettings;
  general: GeneralConversationSettings;
  promptRegion: PromptRegionConversationSettings;
  proximityPrompt: ProximityPromptConversationSettings;
  speechBubble: SpeechBubbleConversationSettings;
}

export type GeneralConversationSettings = {
  --[[
    The character's name. Themes may show this name to the player during the conversation.
  ]]
  name: string?;

  --[[
    Change this to a theme you've added to the Themes folder in order to override default theme settings.
  ]]
  theme: ModuleScript?;

  -- If true, the player will freeze when the dialogue starts and will be unfrozen when the dialogue ends.
  shouldFreezePlayer: boolean; 
}

export type OptionalConversationSettings = {
  general: {
    --[[
      The character's name. Themes may show this name to the player during the conversation.
    ]]
    name: string?;

    --[[
      Change this to a theme you've added to the Themes folder in order to override default theme settings.
    ]]
    theme: ModuleScript?;

    -- If true, the player will freeze when the dialogue starts and will be unfrozen when the dialogue ends.
    shouldFreezePlayer: boolean?; 
  }?;
  distance: {
    -- Maximum magnitude between the NPC's HumanoidRootPart and the player's PrimaryPart before the conversation ends. Requires EndConversationIfOutOfDistance to be true.
    maxConversationDistance: number?;
    relativePart: BasePart?;
  }?;
  typewriter: {
    -- The delay between each letter being typed. 
    characterDelaySeconds: number?; 
    -- If true, the player can skip the typing delay by pressing a keybind or clicking the theme. 
    canPlayerSkipDelay: boolean?; 
  }?;
  humanoid: {
    -- If true, the NPC will look at the player during the conversation.
    shouldLookAtPlayer: boolean?; 
    -- The maximum angle of the NPC's neck on the X axis. Requires NPCLooksAtPlayerDuringDialogue to be true. 
    neckRotationMaxX: number?;
    -- The maximum angle of the NPC's neck on the Y axis. Requires NPCLooksAtPlayerDuringDialogue to be true. 
    neckRotationMaxY: number?; 
    -- The maximum angle of the NPC's neck on the Z axis. Requires NPCLooksAtPlayerDuringDialogue to be true.
    neckRotationMaxZ: number?; 
  }?;
  promptRegion: {
    -- The conversation will automatically start when the player touches this part.
    basePart: BasePart?; 
  }?;
  clickDetector: {
    -- If true, this automatically creates a ClickDetector inside of the NPC's model. 
    shouldAutoCreate: boolean?; 
    -- If true, the ClickDetector's parent will be nil until the dialogue is over. This hides the cursor from the player. 
    shouldDisappearDuringConversation: boolean?; 
    -- Replace this with the location of the ClickDetector. (Ex. workspace.Model.ClickDetector) This setting will be ignored if AutomaticallyCreateClickDetector is true. 
    instance: ClickDetector?;
    adornee: Instance?;
  }?;
  proximityPrompt: {
    -- If true, this automatically creates a ProximityPrompt inside of the NPC's model.
    shouldAutoCreate: boolean?; 
    -- The location of the ProximityPrompt. (Ex. workspace.Model.ProximityPrompt) This setting will be ignored if AutoCreate is true. 
    instance: ProximityPrompt?; 
  }?;
  speechBubble: {
    -- If true, this automatically creates a BillboardGui inside of the NPC's model.
    shouldAutoCreate: boolean?; 
    adornee: Instance?;
    button: GuiButton?;
    billboardGUI: BillboardGui?;
  }?;
}

export type PromptRegionConversationSettings = {
  -- The conversation will automatically start when the player touches this part.
  basePart: BasePart?; 
}

export type ProximityPromptConversationSettings = {
  -- If true, this automatically creates a ProximityPrompt inside of the NPC's model.
  shouldAutoCreate: boolean; 
  -- The location of the ProximityPrompt. (Ex. workspace.Model.ProximityPrompt) This setting will be ignored if AutoCreate is true. 
  instance: ProximityPrompt?; 
}

export type SpeechBubbleConversationSettings = {
  -- If true, this automatically creates a BillboardGui inside of the NPC's model.
  shouldAutoCreate: boolean; 
  adornee: Instance?;
  button: GuiButton?;
  billboardGUI: BillboardGui?;
}

export type ConversationProperties = {
  moduleScript: ModuleScript;
};

export type ConversationMethods = {
  getChildren: (self: Conversation) -> {Dialogue};
  getSettings: (self: Conversation) -> ConversationSettings;
  setSettings: (self: Conversation, settings: ConversationSettings) -> ();
};

export type Conversation = ConversationProperties & ConversationMethods;

-- Dialogue
export type Dialogue = DialogueProperties & DialogueMethods;

export type Page = {string | Effect};

export type GetContentFunction = (self: Dialogue) -> Page;

export type DialogueProperties = {

  --[[
    The dialogue type.
  ]]
  type: "Message" | "Response" | "Redirect";

  --[[
    The ModuleScript that this dialogue was created from.
  ]]
  moduleScript: ModuleScript;

}

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
  verifyCondition: (self: Dialogue) -> boolean;

  --[[
    Finds the next dialogue that should be shown to the player. This returns nil if no verified dialogue is found.
  ]]
  findNextVerifiedDialogue: (self: Dialogue) -> Dialogue?;

  --[[
    Runs a user-defined function that is intended to run before a message is shown, or before a redirect.
  ]]
  runInitializationAction: (self: Dialogue, client: Client) -> ();

  --[[
    Runs a user-defined function that is intended to run after a message is shown.

    Some themes may request a specific dialogue to be shown. For example, when a player chooses a response.
    Any applicable requested dialogue is passed as an argument to this function.

    This function is not intended for redirects.
  ]]
  runCompletionAction: (self: Dialogue, client: Client, requestedDialogue: Dialogue?) -> ();

  --[[
    Gets the dialogue settings.
  ]]
  getSettings: (self: Dialogue) -> DialogueSettings;

  --[[
    Sets the dialogue settings.

    This will overwrite any existing settings, so be sure to include all settings you want to keep.
  ]]
  setSettings: (self: Dialogue, newSettings: DialogueSettings) -> ();

  --[[
    Gets the dialogue's children, which are dialogues that are linked to this dialogue.
    This is used for redirects and responses.
  ]]
  getChildren: (self: Dialogue) -> {Dialogue};

}

export type ThemeDialogueSettings = {

  --[[
    The ModuleScript that contains the theme for this dialogue.
    This is prioritized over the conversation and client themes.
  ]]
  moduleScript: ModuleScript?;

}

export type OptionalThemeDialogueSettings = {

  moduleScript: ModuleScript?;

}

export type DialogueSettings = {
  theme: ThemeDialogueSettings;
  typewriter: TypewriterDialogueSettings;
}

export type OptionalDialogueSettings = {
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
  conversation: Conversation;
  dialogue: Dialogue;
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
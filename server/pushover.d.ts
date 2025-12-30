declare module 'pushover-notifications' {
  interface PushoverOptions {
    user: string;
    token: string;
  }

  interface PushoverMessage {
    message: string;
    title?: string;
    sound?: string;
    priority?: number;
  }

  class Push {
    constructor(options: PushoverOptions);
    send(message: PushoverMessage, callback: (err: any, result: any) => void): void;
  }

  export = Push;
}

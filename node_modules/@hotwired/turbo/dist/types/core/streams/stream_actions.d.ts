import { StreamElement } from "../../elements/stream_element";
export declare type TurboStreamAction = (this: StreamElement) => void;
export declare type TurboStreamActions = {
    [action: string]: TurboStreamAction;
};
export declare const StreamActions: TurboStreamActions;

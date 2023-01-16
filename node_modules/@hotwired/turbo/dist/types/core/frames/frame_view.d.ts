import { FrameElement } from "../../elements";
import { Snapshot } from "../snapshot";
import { View, ViewRenderOptions } from "../view";
export declare type FrameViewRenderOptions = ViewRenderOptions<FrameElement>;
export declare class FrameView extends View<FrameElement> {
    invalidate(): void;
    get snapshot(): Snapshot<FrameElement>;
}

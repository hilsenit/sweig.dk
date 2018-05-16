import { Injectable } from '@angular/core';

@Injectable()

export class AnimationService {
  left_pos: string = "500px";

  transitionMoveEffect(element, animation_go: boolean, class_to_add_remove: string = 'nav-image-move'): void {
    // remember !important on class_to_add_remove in your css
    if(animation_go) {
      element.style.backgroundPositionX = this.left_pos;
      // element.classList.add(class_to_add_remove);
    } else { 
      let position = window.getComputedStyle(element).backgroundPositionX;
      this.left_pos = this.getNewPos(position);
      element.style.backgroundPositionX = position;
    }
  }

  getNewPos(position) { // It's speeding up
    let without_px_new = position.replace('px', '');
    return (Number(without_px_new) + 500) + 'px';
  }
}

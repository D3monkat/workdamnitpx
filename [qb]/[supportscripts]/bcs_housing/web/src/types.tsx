export interface PlanProps {
  interest: number;
  duration: number;
  type: string;
  result: number;
}

export interface SelectionProps {
  title: string;
  subtitle: string;
  boxes: SelectionBoxes[];
}

export interface SelectionBoxes {
  text: {
    title: string;
    body: string;
  };
  icon?: string;
  event: string;
  server?: boolean;
  args?: string[];
}

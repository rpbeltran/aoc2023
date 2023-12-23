const fs = require('fs');

class Signal {
    sender: string
    receiver: string
    pulse: boolean

    constructor(sender: string, receiver: string, pulse: boolean) {
        this.sender = sender;
        this.receiver = receiver;
        this.pulse = pulse;
    }
}


abstract class Thingy {
    name: string
    listeners: string[]

    constructor(name: string, listeners: string[]) {
        this.name = name;
        this.listeners = listeners;
    }

    send(pulse: boolean): Signal[] {
        return this.listeners.map(l => new Signal(this.name, l, pulse));
    }

    abstract receive(signal: Signal): Signal[];
}


class FlipFlop extends Thingy {
    state: boolean;

    constructor(name: string, listeners: string[]) {
        super(name, listeners);
        this.state = false
    }

    receive(signal: Signal): Signal[] {
        if (signal.pulse)
            return []
        return this.send(this.state = !this.state);
    }
}


class Conjunction extends Thingy {
    states: Map<string, boolean>;
    accumulator: number;

    constructor(name: string, listeners: string[], inputs: string[]) {
        super(name, listeners);
        this.states = new Map(inputs.map(i => [i, false]));
        this.accumulator = this.states.size;

    }

    add_input(input: string) {
        this.accumulator += 1;
        this.states.set(input, false);
    }

    all_states(): boolean {
        return this.accumulator == 0
    }

    receive(signal: Signal): Signal[] {
        if (this.states.get(signal.sender) == false && signal.pulse)
            this.accumulator -= 1;
        if (this.states.get(signal.sender) == true && !signal.pulse)
            this.accumulator += 1;
        this.states.set(signal.sender, signal.pulse);

        return this.send(this.accumulator != 0);
    }
}


class Broadcaster extends Thingy {
    constructor(name: string, listeners: string[]) {
        super(name, listeners);
    }

    receive(signal: Signal): Signal[] {
        return this.send(signal.pulse);
    }
}


class Problem {
    thingys: Map<string, Thingy>
    conjunctions : string[]
    low_count: number
    high_count: number

    constructor() {
        this.thingys = new Map();
        this.conjunctions = []
        this.low_count = 0
        this.high_count = 0
    }

    parse_and_add(thing: string) {
        let parts = thing.split(" -> ");
        let module_type = parts[0][0];
        let name = parts[0].slice(1);
        let listeners = parts[1].split(", ");

        this.conjunctions.forEach((con_name) =>{
            if (listeners.indexOf(con_name) >= 0)
                (this.thingys.get(con_name) as Conjunction).add_input(name)
        });

        switch (module_type) {
            case "%":
                this.thingys.set(name, new FlipFlop(name, listeners));
                break
            case "&":
                var inputs: string[] = [];
                this.thingys.forEach((t, _) => {
                    if (t.listeners.indexOf(name) >= 0)
                        inputs.push(t.name);
                })
                this.thingys.set(name, new Conjunction(name, listeners, inputs));
                this.conjunctions.push(name);
                break
            default:
                this.thingys.set(parts[0], new Broadcaster(parts[0], listeners));
                break
        }
    }

    press_button(test_node: string = "", pulse: boolean = true): boolean {
        var signals = [ new Signal("button", "broadcaster", false) ];
        var low_rx = false
        while (signals.length > 0) {
            var new_signals: Signal[] = [];
            for (var sig of signals) {
                if (sig.sender == test_node) {
                    if (sig.pulse == pulse) {
                        low_rx = true
                    }
                }
                if (sig.pulse)
                    this.high_count += 1
                else
                    this.low_count += 1
                let newest = this.thingys.get(sig.receiver)?.receive(sig)
                if (newest) {
                    new_signals.push(...newest)
                }   
            }
            signals = new_signals;
        }
        return low_rx
    }

    press_button_repeatedly(times: number) {
        for (let i = 1; i < times + 1; i++) {
            this.press_button()
        }
    }

    get_cycle(test_node: string = "", pulse: boolean = true) {
        var first = 0; 
        for (let i = 1; ; i++) {
            if (this.press_button(test_node, pulse)) {
                if (first) {
                    return i - first
                } else {
                    first = i
                }
            }
        }
    }
}

let problem = new Problem();



const allFileContents = fs.readFileSync('input.txt', 'utf-8');
allFileContents.split(/\r?\n/).forEach((line: string) =>  {
    problem.parse_and_add(line);
});

problem.press_button_repeatedly(1000)
console.log("Part1: ", problem.low_count * problem.high_count);


let time_to_low = 1;
problem.thingys.forEach((node, name) => {
    if (node.listeners.indexOf("zh") >= 0)
        time_to_low *= problem.get_cycle(name, true);
})

console.log("Part 2: ", time_to_low);
